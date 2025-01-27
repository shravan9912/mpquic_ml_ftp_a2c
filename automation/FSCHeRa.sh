echo "2"
tc qdisc add dev h1-eth0 root netem delay 74ms loss 0.5% rate 105mbit
tc qdisc add dev h1-eth1 root netem delay 74ms loss 0.5% rate 105mbit
generate_random_number() {
    random_number=$((RANDOM % 9 + 1))
    decimal_part=$((RANDOM % 10))
    result="1.$random_number$decimal_part"
    echo "$result"
}
while :
do
       
	echo "changing Max Mbps"
	tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.5% rate 45mbit
	tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.5% rate 105mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	s=$(generate_random_number)
	sleep $s
	echo "changing to Max Mbps"
        tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.5% rate 45mbit
	tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.5% rate 105mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	s=$(generate_random_number)
	sleep $s
	echo "changing to Max Mbps"
        tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.5% rate 45mbit
	tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.5% rate 105mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	s=$(generate_random_number)
	sleep $s
	echo "changing to Max Mbps"
        tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.5% rate 45mbit
	tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.5% rate 105mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	sleep $s
	echo "changing to Max Mbps"
        tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.5% rate 45mbit
	tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.5% rate 105mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	s=$(generate_random_number)
	sleep $s
	echo "changing to Min Mbps"
	tc qdisc change dev h1-eth0 root netem delay 71ms loss 0.5% rate 36mbit
	tc qdisc change dev h1-eth1 root netem delay 87ms loss 0.5% rate 37mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	s=$(generate_random_number)
	sleep $s
	echo "changing to Min Mbps"
	tc qdisc change dev h1-eth0 root netem delay 71ms loss 0.5% rate 36mbit
	tc qdisc change dev h1-eth1 root netem delay 87ms loss 0.5% rate 37mbit
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	sleep $s
	echo "changing to Min Mbps"
	tc qdisc change dev h1-eth0 root netem delay 71ms loss 0.5% rate 36mbit
	tc qdisc change dev h1-eth1 root netem delay 87ms loss 0.5% rate 37mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	sleep $s
	echo "changing to Min Mbps"
	tc qdisc change dev h1-eth0 root netem delay 71ms loss 0.5% rate 36mbit
	tc qdisc change dev h1-eth1 root netem delay 87ms loss 0.5% rate 37mbit
	s=$(generate_random_number)
	sleep $s
        echo "changing to Avg Mbps"
	tc qdisc change dev h1-eth0 root netem delay 57ms loss 0.5% rate 42mbit
	tc qdisc change dev h1-eth1 root netem delay 80ms loss 0.5% rate 68mbit
	s=$(generate_random_number)
	sleep $s	
done
