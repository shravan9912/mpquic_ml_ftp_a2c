#!/bin/bash

# CSV file
csv_file="5ginputfile.csv"
generate_random_number() {
    random_number=$((RANDOM % 9 + 1))
    decimal_part=$((RANDOM % 10))
    s="0.$random_number$decimal_part"
    echo "$s"
}
s=1
while true; do
    # Define column names and positions (1-based)
    declare -A col_positions=(
        ["path1_bw"]=1
        ["path1_loss"]=2
        ["path1_delay"]=3
        ["path2_bw"]=4
        ["path2_loss"]=5
        ["path2_delay"]=6
    )

    # Declare variables to store column values
    path1_bw=""
    path1_loss=""
    path1_delay=""
    path2_bw=""
    path2_loss=""
    path2_delay=""

    # Read and store column values in variables
    while IFS=, read -r line; do
        for col in "${!col_positions[@]}"; do
            position="${col_positions[$col]}"
            value=$(echo "$line" | awk -F ',' -v pos="$position" '{print $pos}')
            # Store values in respective variables
            eval "${col}=\"$value\""
        done

        # Print the values for each column
        echo "path1_bw: $path1_bw path1_loss: $path1_loss path1_delay: $path1_delay"
        tc qdisc change dev h1-eth0 root netem delay "$path1_delay"ms loss "$path1_loss" rate "$path1_bw"mbit
        echo "path2_bw: $path2_bw path2_loss: $path2_loss path2_delay: $path2_delay"
        tc qdisc change dev h1-eth1 root netem delay "$path2_delay"ms loss "$path2_loss" rate "$path2_bw"mbit
        s=$(generate_random_number)
        sleep $s

    done < <(tail -n +2 "$csv_file")
done

