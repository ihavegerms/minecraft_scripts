#!/bin/bash

for session in $(screen ls | grep -o '[0-9]\{3,\}\.S*')
  do
    screen -r MinecraftServer -p0 -X stuff "&9Server is restarting.\015"
    screen -r MinecraftServer -p0 -X stuff "stop\015" # send "stop\r" to the minecraft server
  done

counter=0
while [$(screen -ls | grep -c 'No Sockets found in') -lt 1]; do
  if [ $(( $counter %10 )) -eq 0]; then
    echo 'A previous server is in use. Waiting for 10 seconds before starting server.'
  fi

  sleep 1
  counter=$((counter+1))
done

echo "Starting Server..."

screen -dmS "MinecraftServer" java -Xmx512 -Xms2000 -jar forge-1.16.1-32.0.63.jar
sleep 1
while [ $(screen ls | grep -c "No Sockets found in") -ge 1 ]; do
  echo 'Waiting for 5 seconds to start the server...'
  sleep 5
  screen -dmS "MinecraftServer" java -Xmx512 -Xms2000 -jar forge-1.16.1-32.0.63.jar
done

echo "Server started."
