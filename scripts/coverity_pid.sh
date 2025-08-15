#!/bin/bash

# Check if the process_id.txt file exists and remove it 
if [ -f "process_id.txt" ]; then
    rm -f "process_id.txt"
fi


# Define server Details 

servers=("3.110.221.94" "13.232.88.73")
port="5432"
usernames=("postgres" "postgres")	
db=("mine" "mine")
export PGPASSWORD=test1

# Iterate over each pair of host and database
for ((i=0; i<${#servers[@]}; i++)); do
    server="${servers[i]}"
    database="${db[i]}"
	username="${usernames[i]}"
	
    psql -h "$server" -p "$port" -d "$database" -U "$username" <<EOF >> process_id.txt
    SELECT 'SELECT pg_terminate_backend(' || pid || ');'
    FROM pg_stat_activity;
EOF

    echo "Processes terminated on $server for $database"
    echo "Success"

    # Remove unwanted lines from the file
    sed -i -e '1,2d' -e '/row/d' process_id.txt

    # Execute the commands stored in process_id.txt
    while IFS= read -r command; do
         echo "$command" | psql -h "$server" -p "$port" -d "$database" -U "$username"
    done < process_id.txt

    sleep 10

   > process_id.txt
   
    echo "Executing IFS commands for $server and $database"

    sleep 80
done
