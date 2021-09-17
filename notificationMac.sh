OS=`uname -s`
if  [ $OS == "Darwin" ]; then
    osascript -e 'display notification "do Approve chaincode" with title "Run Fabric Done"'    
fi