#!/bin/bash

function clean_shutdown {
  kill $cron_pid
  . bin/sync-from-s3.sh
}
trap clean_shutdown SIGTERM

# create server config
echo "server-port=25566" > /app/server.properties

# sync initial files
ruby bin/sync.rb init

# print logs to stdout
touch server.log
nice tail -f server.log &

# Default minecraft version
if [ -z "$MC_VERSION" ]; then
    export MC_VERSION=1.7.10
fi

# downloading minecraft
curl -o vendor/minecraft_server.${MC_VERSION}.jar https://s3.amazonaws.com/Minecraft.Download/versions/${MC_VERSION}/minecraft_server.${MC_VERSION}.jar

# run minecraft
java -Xmx1024M -Xms1024M -jar vendor/minecraft_server.${MC_VERSION}.jar nogui
