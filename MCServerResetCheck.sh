#!/bin/bash

if ! screen -list | grep -q MinecraftServer; then
    echo "$(date) $(ls -l | wc -l);" >> /opt/minecraft/MCServerRestartLog.txt 2>&1
    cd /opt/minecraft
  "/opt/minecraft/StartMinecraft.sh" | sed 's/^/  /' >> /opt/minecraft/MCServerRestartLog.txt 2>&1
fi
