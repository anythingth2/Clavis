var Web3 = require('web3');
var Tranx = require('ethereumjs-tx').Transaction
require('dotenv').config()

//  init web3
var web3 = new Web3(`https://kovan.infura.io/v3/${process.env.INFURA_API_KEY}`);
var privateKey = process.env.USER_PRIVATEKEY;
var userAddress = '0x7c125a0a305cFdC11F7EfE9aC48A11f60a27EDA4';


//=============== for test variable ==============================
var contractAddress = "0x3836F74dE3CE532146237b75193c6C5053E712eF";
var contractABI = require("./contractABI.json");
var contractObject = new web3.eth.Contract(contractABI.abi,contractAddress);

// =================== state Data =========================

var verifyCode = ""

// ======================= ENUM ==================================

const params = {
    ADA: '0x00000000',
    BAND: '0x00000001',
    BCH: '0x00000002',
    BNB: '0x00000003',
    BTC: '0x00000004',
    EOS: '0x00000005',
    ETC: '0x00000006',
    ETH: '0x00000007',
    LTC: '0x00000008',
    TRX: '0x00000009',
    XRP: '0x0000000a',
}

const codeHash = {
    binancePrice : "6b7be61b150aec5eb853afb3b53e41438959554580d31259a1095e51645bcd28",
    coinGeckoPrice : "d10a439e08c31902cfed8d337e68f297c84665c36c1025caa60ce6bbd2767715",
    cryptoComparePrice : "06077e219b9bceb3ca90240d5f9d383e418e9916a9da02fce7aa441d279af2d4"
}

// ==================== Execute Zone ================================

console.log(getVerifyCode())


// ========================= assist function ==============================

// get verify code (_reportValue in update function) to use in update function
function getVerifyCode(_params,_codeHash){
    let headers = {
        "Content-Type" : "application/json",
    }
    let data = { 
        "type":"FULL",
        "params":{ "crypto_symbol": _params  },
        "codeHash": _codeHash
    }
    axios.post(`http://rpc.alpha.bandchain.org/bandsv/request`, JSON.stringify(data) , {"headers" : headers })
        .then(function (response) {
            // handle success
            console.log(response)
            return response
            
        })
        .catch(function (error) {
            // handle error
            console.log(error);
        })
}

// call update in smart contract to provide data to it 
function updateData(from,_contractAddress,param1,_privateKey){
    contractObject.methods.update(from,param1).estimateGas({from: from})
        .then(function(gasAmount){
            let tx_builder = contractObject.methods.update(from,param1);
            let tx_encoded = tx_builder.encodeABI();
        
            web3.eth.getTransactionCount(from,'pending')
            .then((res)=>{
                console.log("nonce is : ",res)
                var txObject ={
                    nonce : web3.utils.toHex(res),
                    gasLimit : web3.utils.toHex(Math.floor(gasAmount+0.2*gasAmount)),
                    gasPrice : "0x09184e72a000",
                    data : tx_encoded,
                    from : from,
                    value: '0x00',
                    to : _contractAddress
                }
                const tx = new Tranx(txObject,{chain:'ropsten', hardfork: 'petersburg'});
                const privateKey = Buffer.from(
                    _privateKey,
                    'hex',
                )
                tx.sign(privateKey);
        
                const serializedTX = tx.serialize();
                const rawTX = "0x" + serializedTX.toString("hex");
        
                web3.eth.sendSignedTransaction(rawTX).then((reciept)=>{
                    console.log("reciept : ",reciept);
                })
            })

            console.log(gasAmount);
        })
        .catch(function(error){
          console.log(error)
    });
}

// set code hash in smart contract to change data source api
function setCodeHash(from,_contractAddress,param1,_privateKey){
    contractObject.methods.setCodeHash(from,param1).estimateGas({from: from})
        .then(function(gasAmount){
            let tx_builder = contractObject.methods.setCodeHash(from,param1);
            let tx_encoded = tx_builder.encodeABI();
        
            web3.eth.getTransactionCount(from,'pending')
            .then((res)=>{
                console.log("nonce is : ",res)
                var txObject ={
                    nonce : web3.utils.toHex(res),
                    gasLimit : web3.utils.toHex(Math.floor(gasAmount+0.2*gasAmount)),
                    gasPrice : "0x09184e72a000",
                    data : tx_encoded,
                    from : from,
                    value: '0x00',
                    to : _contractAddress
                }
                const tx = new Tranx(txObject,{chain:'ropsten', hardfork: 'petersburg'});
                const privateKey = Buffer.from(
                    _privateKey,
                    'hex',
                )
                tx.sign(privateKey);
        
                const serializedTX = tx.serialize();
                const rawTX = "0x" + serializedTX.toString("hex");
        
                web3.eth.sendSignedTransaction(rawTX).then((reciept)=>{
                    console.log("reciept : ",reciept);
                })
            })

            console.log(gasAmount);
        })
        .catch(function(error){
          console.log(error)
    });
}

// set params in smart contract
function setParams(from,_contractAddress,param1,_privateKey){
    contractObject.methods.setParams(from,param1).estimateGas({from: from})
        .then(function(gasAmount){
            let tx_builder = contractObject.methods.setParams(from,param1);
            let tx_encoded = tx_builder.encodeABI();
        
            web3.eth.getTransactionCount(from,'pending')
            .then((res)=>{
                console.log("nonce is : ",res)
                var txObject ={
                    nonce : web3.utils.toHex(res),
                    gasLimit : web3.utils.toHex(Math.floor(gasAmount+0.2*gasAmount)),
                    gasPrice : "0x09184e72a000",
                    data : tx_encoded,
                    from : from,
                    value: '0x00',
                    to : _contractAddress
                }
                const tx = new Tranx(txObject,{chain:'ropsten', hardfork: 'petersburg'});
                const privateKey = Buffer.from(
                    _privateKey,
                    'hex',
                )
                tx.sign(privateKey);
        
                const serializedTX = tx.serialize();
                const rawTX = "0x" + serializedTX.toString("hex");
        
                web3.eth.sendSignedTransaction(rawTX).then((reciept)=>{
                    console.log("reciept : ",reciept);
                })
            })

            console.log(gasAmount);
        })
        .catch(function(error){
          console.log(error)
    });
}