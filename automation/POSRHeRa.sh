echo "2"
tc qdisc add dev h1-eth0 root netem delay 44ms loss 0.9% rate 45mbit
tc qdisc add dev h1-eth1 root netem delay 74ms loss 0.9% rate 104mbit
generate_random_number() {
    random_number=$((RANDOM % 9 + 1))
    decimal_part=$((RANDOM % 10))
    s="1.$random_number$decimal_part"
    echo "$s"
}
s=1
while :
do
	
	echo "changing Max Mbps"
       tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.9% rate 45mbit
       tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.9% rate 104mbit
       s=$(generate_random_number)
       sleep $s
       echo "changing to Min Mbps"
       tc qdisc change dev h1-eth0 root netem delay 71ms loss 0.9% rate 36mbit
       tc qdisc change dev h1-eth1 root netem delay 87ms loss 0.9% rate 37mbit
       s=$(generate_random_number)
       sleep $s
       sleep $s
       echo "changing to Outage Mbps"
       tc qdisc change dev h1-eth0 root netem delay 1ms loss 0.9% rate 1mbit
       tc qdisc change dev h1-eth1 root netem delay 1ms loss 0.9% rate 1mbit
       s=$(generate_random_number)
       sleep $s
       echo "changing Max Mbps"
       tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.9% rate 45mbit
       tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.9% rate 104mbit
       s=$(generate_random_number)
       sleep $s
       sleep $s
       echo "changing to Outage Mbps"
       tc qdisc change dev h1-eth0 root netem delay 1ms loss 0.9% rate 1mbit
       tc qdisc change dev h1-eth1 root netem delay 1ms loss 0.9% rate 1mbit
       s=$(generate_random_number)
       sleep $s
       echo "changing to Min Mbps"
       tc qdisc change dev h1-eth0 root netem delay 71ms loss 0.9% rate 36mbit
       tc qdisc change dev h1-eth1 root netem delay 87ms loss 0.9% rate 37mbit
       s=$(generate_random_number)
       sleep $s
       sleep $s
       echo "changing Max Mbps"
       tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.9% rate 45mbit
       tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.9% rate 104mbit
       s=$(generate_random_number)
       sleep $s
       sleep $s


			
done
