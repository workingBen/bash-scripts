#!/bin/bash

workspace_path="~/workspace"
name=`whoami`
greeting="Hey $name! CrashPad is started!"

function run_cmd {
return=`/usr/bin/osascript << EOT
  activate app "Terminal"
  tell application "System Events"
    tell process "Terminal"
      keystroke "t" using {command down}
    end tell
  end tell

  delay 1

  tell app "Terminal"
    do script "cd $workspace_path/$1; $2" in the last tab of window 1
  end tell
EOT`
echo $return
}

mongod run --config /usr/local/Cellar/mongodb/2.0.2-x86_64/mongod.conf > /dev/null 2>&1 &
run_cmd 'crashpad' 'rails s' # using Pry instead of IRB with ruby-debug. Dont need to start the server in debug mode anymore
run_cmd 'crashpad' 'rails c'
run_cmd 'okcl_user_service' 'rackup -p9292'
run_cmd 'omniscience' 'rackup -p9393'
clear
echo $greeting
say $greeting
