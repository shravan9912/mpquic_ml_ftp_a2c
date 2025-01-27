package a2
import (
	"fmt"
	//"math"
	//"math/rand"
	//"encoding/csv"
	"encoding/gob"
	"os"
	//"strconv"
	//"time"
	"gonum.org/v1/gonum/mat"
)
// ActorCritic represents the model
type ActorCritic struct {
	weights *mat.Dense // Weights for the policy
	values  *mat.Dense // Weights for the value function
}



// Save the model as a binary file
func SaveModelBinary(model *ActorCritic, filename string) error {
	// Create file
	file, err := os.Create(filename)
	if err != nil {
		return err
	}
	defer file.Close()

	// Serialize the model using gob
	encoder := gob.NewEncoder(file)
	if err := encoder.Encode(model); err != nil {
		return err
	}

	fmt.Println("Model saved as binary file:", filename)
	return nil
}

// Load the model from a binary file
func LoadModelBinary(filename string) (*ActorCritic, error) {
	// Open file
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	// Deserialize the model using gob
	var model ActorCritic
	decoder := gob.NewDecoder(file)
	if err := decoder.Decode(&model); err != nil {
		return nil, err
	}

	fmt.Println("Model loaded from binary file:", filename)
	return &model, nil
}
