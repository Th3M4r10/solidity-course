const { ethers } = require("ethers");

const sender_private_key = "<PRIVATE_KEY>";
const receiver_address = "0xb054730114664A3E9E983D29c1f0231Fec9Ed9B3"; 
const amount = "0.05";

let provider = ethers.getDefaultProvider("sepolia");
let sender_wallet = new ethers.Wallet(sender_private_key, provider);

let tx = {
    to: receiver_address,
    value: ethers.parseEther(amount),  //1 ether = 10^18 wei
};

sender_wallet.sendTransaction(tx).then((result) => {
    console.log("senderAddress: ", sender_wallet.address);
    console.log("txHash: ", result.hash);
});


/*
m4r10@ARLinux:~/Desktop/ethers-scripts$ node send-ether.js 
senderAddress:  0x2C83878DEB725e83e235a5a9182394a974aef438
txHash:  0x57ca2e0cc99be09dbc8b95b6f43b5c16f8b006bbfa97fc2833afbb7dd02bea6b
*/


/*

[ This is a Sepolia Testnet transaction ]
Transaction Hash:
0x57ca2e0cc99be09dbc8b95b6f43b5c16f8b006bbfa97fc2833afbb7dd02bea6b 
Status:
Success
Block:
4923061
311 Block Confirmations
From:
0x2C83878DEB725e83e235a5a9182394a974aef438
To:
0xb054730114664A3E9E983D29c1f0231Fec9Ed9B3
Value:
0.05 ETH
($0.00)
Transaction Fee:
0.001269213484686 ETH
($0.00)
Gas Price:
60.438737366 Gwei (0.000000060438737366 ETH)

*/
