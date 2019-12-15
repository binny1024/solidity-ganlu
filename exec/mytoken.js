const BN = require("bn.js");

const MyToken = artifacts.require("MyToken");

let frac = new BN(10);

module.exports = async function (callback) {

    try {
        // Get the deployed instance of our token contract
        let instance = await MyToken.deployed();

        // await instance.inflate();


        let accounts = await web3.eth.getAccounts();


        let address = [];
        let i = 0;
        for (i = 0; i < accounts.length; i++) {
            console.log("adderss = " + accounts[i]);
            address.push(accounts[i]);
        }
        let response = await instance.batchTransfer(address, web3.utils.toWei('10','ether'));

        for (i = 0; i < accounts.length; i++) {
            await printBalance(accounts[i], instance);
        }
        callback();
    } catch (e) {
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
