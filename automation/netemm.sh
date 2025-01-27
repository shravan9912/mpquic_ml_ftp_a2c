tc qdisc add dev h1-eth0 root netem 
tc qdisc add dev h1-eth1 root netem 
#tc qdisc change dev h1-eth0 root netem delay 50ms loss 2% rate 8mbit
#tc qdisc change dev h1-eth1 root netem delay 70ms loss 0.0001% rate 16mbit
