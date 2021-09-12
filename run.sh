if [ -z "$1" ]; then    
    ./host1up.sh
    ./host3up.sh
    sleep 5 
    ./mychannelup.sh
fi 

if [ "$1" == "pc1" ]; then    
    ./host1up.sh
fi 

if [ "$1" == "pc2" ]; then    
    ./host3up.sh
fi

if [ "$1" == "channel-up" ]; then
    ./mychannelup.sh
fi

if [ "$1" == "pc1-couchdb" ]; then
    docker-compose -f host1-couchdb.yaml up -d
fi

if [ "$1" == "pc2-couchdb" ]; then
    docker-compose -f host3-couchdb.yaml up -d
fi
 

if [ "$1" == "deploy-chaincode" ]; then    
    ./deploychaincode.sh
fi 

#if not vendoring already
#docker exec cli /bin/bash -c 'cd /opt/gopath/src/github.com/chaincode/chaincode-go; go get github.com/hyperledger/fabric-samples/asset-transfer-basic/chaincode-go/chaincode; go get github.com/hyperledger/fabric-contract-api-go/contractapi; go mod vendor;'

if [ "$1" == "all-up" ]; then
    ./host1up.sh
    ./host3up.sh
    ./mychannelup.sh
    ./deploychaincode.sh
fi
