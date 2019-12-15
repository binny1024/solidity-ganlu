const BN = require("bn.js");

const MyToken = artifacts.require("MyToken");

let frac = new BN(10);

module.exports = async function (callback) {

    try{
        // Get the deployed instance of our token contract
        let instance = await MyToken.deployed();

        let response = await instance.inflate();

        let accounts = await web3.eth.getAccounts();
        await printBalance(accounts[0], instance);
        await printBalance(accounts[1], instance);

        callback();
    }catch (e) {
        console.log("e: " + e.stack);
    }

};

async function printBalance(account, instance) {
    console.log("---------------------------------------------------------------");
    console.log("Account: " + account);
    let balance = await instance.balanceOf(account);
    console.log("Balance: " + balance.div(frac).toString());
    console.log("---------------------------------------------------------------");
}
