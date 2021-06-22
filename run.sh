if [ -z "$1" ]; then    
    ./host1up.sh
    ./host3up.sh
    sleep 5 
    ./mychannelup.sh
fi 

if [ "$1" == "pc1" ]; then    
    ./host1up.sh
    sleep 5 
    ./mychannelup.sh
fi 

if [ "$1" == "pc2" ]; then    
    ./host3up.sh
fi 

if [ "$1" == "deploy-chaincode" ]; then    
    
    pushd ../chaincode/fabcar/go
    GO111MODULE=on go mod vendor
    popd
    sleep 5

    # package
    docker exec cli peer lifecycle chaincode package fabcar.tar.gz --path github.com/chaincode/fabcar/go --label fabcar_1
    sleep 3

    # peer0.org1
    docker exec cli peer lifecycle chaincode install fabcar.tar.gz
    sleep 3

    # peer0.org2
    docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer0.org2.example.com:9051 -e CORE_PEER_LOCALMSPID="Org2MSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt cli peer lifecycle chaincode install fabcar.tar.gz
    sleep 3

fi 

#if not vendoring already
#docker exec cli /bin/bash -c 'cd /opt/gopath/src/github.com/chaincode/chaincode-go; go get github.com/hyperledger/fabric-samples/asset-transfer-basic/chaincode-go/chaincode; go get github.com/hyperledger/fabric-contract-api-go/contractapi; go mod vendor;'


