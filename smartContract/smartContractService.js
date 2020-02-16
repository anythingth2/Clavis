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

// ================== ENUM

const params = {
    ETH: '0x00000007',
}

// ==================== Execute Zone ================================

console.log(getVerifyCode())


// ========================= assist function ==============================

function getVerifyCode(){
    let headers = {
        "Content-Type" : "application/json",
    }
    let data = { 
        "type":"FULL",
        "params":{ "crypto_symbol": "ETH"  },
        "codeHash":"06077e219b9bceb3ca90240d5f9d383e418e9916a9da02fce7aa441d279af2d4"
    }
    axios.post(`http://rpc.alpha.bandchain.org/bandsv/request`, JSON.stringify(data) , {"headers" : headers })
        .then(function (response) {
            // handle success
            
        })
        .catch(function (error) {
            // handle error
            console.log(error);
        })
}

function updateData(from,_contractAddress,param1,param2,_privateKey){
    contractObject.methods.update(from,param1,param2).estimateGas({from: from})
        .then(function(gasAmount){
            let tx_builder = contractObject.methods.update(from,param1,param2);
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