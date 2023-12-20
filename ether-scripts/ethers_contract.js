const { ethers } = require("ethers");
 
const sender_private_key =
 "e5ecc5be13c9e747ebe3265b5de0b17ba20dc15434523f17c23c839107427629";
 
let provider = ethers.getDefaultProvider("sepolia");
let sender_wallet = new ethers.Wallet(sender_private_key, provider);

const contract_address = "0x8E8a391B15f4AE7e8E2644580abF26f8Df4a80B6";

const contract_ABI = [
    {
        "inputs":[],
        "stateMutability":"nonpayable",
        "type":"constructor"
    },
    {
        "inputs":[],
        "name":"decrement",
        "outputs":[],
        "stateMutability":"nonpayable",
        "type":"function"
    },
    {   "inputs":[],
        "name":"increment",
        "outputs":[],
        "stateMutability":"nonpayable",
        "type":"function"
    },
    {
        "inputs":[],
        "name":"variable",
        "outputs":[{"internalType":"uint8","name":"","type":"uint8"}],
        "stateMutability":"view","type":"function"
    }
];

const contract = new ethers.Contract(contract_address, contract_ABI, provider);

async function interact() {
    const value = await contract.variable();
    console.log("Previoius Value: ",value);
    const contractWithSigner = contract.connect(sender_wallet);

    const tx = await contractWithSigner.decrement();
    await tx.wait();
    console.log("TxHash: ", tx.hash);

    const newValue = await contract.variable();
    console.log("Current Value: ", newValue);
}
interact();


/*
Output :
m4r10@ARLinux:~/Desktop/ethers-scripts$ node ethers_contract.js
Previoius Value:  3
TxHash:  0x02e94da984df69d058effb75d00fd0d4a47dac13c8cdb5077fd06474a660b502
Current Value:  2
*/

/*
Read contract information: 
1.variable
2 uint8 
*/





