echo "2"
tc qdisc add dev h1-eth0 root netem delay 44ms loss 0.9% rate 45mbit
tc qdisc add dev h1-eth1 root netem delay 74ms loss 0.9% rate 104mbit
# Generate a random number between 1 and 100
random_number=$((RANDOM % 100 + 1))
echo "Random number: $random_number"
s=1
while :
do
	
	echo "changing min Mbps"
	tc qdisc change dev h1-eth0 root netem delay 44ms loss 0.9% rate 45mbit
	tc qdisc change dev h1-eth1 root netem delay 74ms loss 0.9% rate 104mbit
       # Generate a random decimal number between 0.1 and 0.9
       random_number=$((RANDOM % 9 + 1))
       decimal_part=$((RANDOM % 10))
       result1="0.$random_number$decimal_part"
       echo "Random number: $result1"
       sleep $result1
       echo "changing to Max Mbps"
       tc qdisc change dev h1-eth0 root netem delay 71ms loss 0.9% rate 35mbit
       tc qdisc change dev h1-eth1 root netem delay 87ms loss 0.9% rate 37mbit
       # Generate a random decimal number between 0.1 and 0.9
       random_number=$((RANDOM % 9 + 1))
       decimal_part=$((RANDOM % 10))
       result2="0.$random_number$decimal_part"
       sleep $result2

			
done
