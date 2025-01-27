package common

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/tls"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	quic "github.com/shravan9912//mpquic_ml_a2c"
	"github.com/shravan9912/mpquic_ml_ftp_a2c/constants"
	"github.com/teris-io/shortid"
	"io"
	"io/ioutil"
	"log"
	"math/big"
	"os"
	"sync"
	"time"
)

var (
	receivedDataMap = make(map[string]int)
	mutex           = sync.Mutex{}
)

func GenerateTLSConfig() *tls.Config {
	key, err := rsa.GenerateKey(rand.Reader, 1024)
	if err != nil {
		panic(err)
	}
	template := x509.Certificate{SerialNumber: big.NewInt(1)}
	certDER, err := x509.CreateCertificate(rand.Reader, &template, &template, &key.PublicKey, key)
	if err != nil {
		panic(err)
	}
	keyPEM := pem.EncodeToMemory(&pem.Block{Type: "RSA PRIVATE KEY", Bytes: x509.MarshalPKCS1PrivateKey(key)})
	certPEM := pem.EncodeToMemory(&pem.Block{Type: "CERTIFICATE", Bytes: certDER})

	tlsCert, err := tls.X509KeyPair(certPEM, keyPEM)
	if err != nil {
		panic(err)
	}
	return &tls.Config{Certificates: []tls.Certificate{tlsCert}}
}

func WriteBytesWithQUIC(session quic.Session, bytesToSend []byte, logTime bool) {
	stream, err := session.OpenStreamSync()
	logStartTime := time.Now()
	if err != nil {
		log.Fatal("Error Opening Write Stream: ", err)
	}
	sentBytes, _ := stream.Write(bytesToSend)
	fmt.Println("Sent Bytes: ", sentBytes)
	if logTime {
		fmt.Printf("Time Taken to Send File: %f sec\n", time.Now().Sub(logStartTime).Seconds())
	}
	_ = stream.Close()
}

func SendStringWithQUIC(session quic.Session, message string) {
	bytesToSend := []byte(message)
	WriteBytesWithQUIC(session, bytesToSend, false)
}

func SendFileWithQUIC(session quic.Session, filePath string) error {
	fileBytes, err := ioutil.ReadFile(filePath)
	fmt.Println("Read File", filePath)
	if err != nil {
		return fmt.Errorf("file not found: %v", err.Error())
	}
	WriteBytesWithQUIC(session, fileBytes, true)
	return nil
}

func ReadDataWithQUIC(session quic.Session, pathIndex int) string {
	receivedData := ""
	stream, err := session.AcceptStream()
	if err != nil {
		fmt.Println("Data received for Path ", pathIndex, ": ", len(receivedData))
		return receivedData
	}
	logStartTime := time.Now()
	for {
		// Make a buffer to hold incoming data.
		buf := make([]byte, constants.MAX_PACKET_CONTENT_SIZE)
		// Read the incoming connection into the buffer.
		readLen, err := stream.Read(buf)
		if readLen > 0 {
			receivedData += string(buf[:readLen])
		}

		// Exit the loop when the data transfer is done
		if err == io.EOF {
			break
		} else if err != nil {
			log.Fatal("Error reading: ", err.Error(), readLen)
		}
	}

	fmt.Printf("Data received for Path %d: %d \t|| Time Taken To Download File: %f sec\n", pathIndex, len(receivedData),
		time.Now().Sub(logStartTime).Seconds())
	_ = stream.Close()

	// Update the received data in the global map
	mutex.Lock()
	receivedDataMap[fmt.Sprintf("Path%d", pathIndex)] = len(receivedData)
	mutex.Unlock()

	return receivedData
}

func StoreFile(fileName, dirPath, fileData string) {
	if fileData == "" {
		log.Fatal("Error: [FILE_RECEIVE] File doesn't exist or is empty")
	}
	uniqueId, err := shortid.Generate()
	file, err := os.Create(dirPath + "/" + uniqueId + "_" + fileName)
	if err != nil {
		log.Fatal("Error writing the file: ", err)
	}
	_, _ = file.WriteString(fileData)
	_ = file.Close()
}

func PrintTotalReceivedData() {
	mutex.Lock()
	defer mutex.Unlock()

	// Print the total received data for each path
	for path, data := range receivedDataMap {
		fmt.Printf("Total Received Data for '%s': %d bytes\n", path, data)
	}
}

