const Balance = artifacts.require("Balance");

module.exports = async function (callback) {

    // Get the deployed instance of our token contract
    let instance = await Balance.deployed();

    let result = await instance.getMassage(5);

    console.log("result : " + result);
    callback();
};

async function printBalance(account, instance) {
    console.log("---------------------------------------------------------------");
    console.log("Account: " + account);
    let balance = await instance.balanceOf(account);
    console.log("Balance: " + balance.div(frac).toString());
    console.log("---------------------------------------------------------------");
}
