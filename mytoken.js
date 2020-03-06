const BN = require("bn.js");

const MyToken = artifacts.require("MyToken");

let frac = new BN(10);

module.exports = async function (callback) {
    try {


        // Get the deployed instance of our token contract
        let instance = await MyToken.deployed();
        // console.log("Contract instance address: " + JSON.stringify(instance));

        // Get token name
        let name = await instance.getName();
        console.log("Token name: " + name);

        // Check decimals
        let decimals = await instance.getDecimals();
        console.log("Token decimals: " + decimals);

        frac = frac.pow(new BN(decimals));

        // Check the total supply
        let totalSupply = await instance.totalSupply();
        console.log("Total supply: " + totalSupply.div(frac).toString());

        // Get account list from ganache
        let accounts = await web3.eth.getAccounts();

        if (accounts.length < 2) {
            callback(new Error("accounts not enough"));
            return;
        }
        // console.log(" 账户信息:" + accounts);
        // Show account balances
        // console.log("Before transferring:");
        // await printBalance(accounts[0], instance);
        // await printBalance(accounts[1], instance);

        // Send a transaction to transfer 15 tokens from account 0 to account 1

        //

        let c_address = instance.address;//合约地址
        console.log("instance.address = " + instance.address);
        let response = await web3.eth.sendTransaction({
            from: accounts[1],
            to: c_address,
            value: '2000000000000000000'
        });

        // console.log("Transaction hash: " + JSON.stringify(response));

        // console.log("After transferring:");
        // await printBalance(accounts[0], instance);
        // await printBalance(accounts[1], instance);


        let value = frac.mul(new BN(100));
        let amount = frac.mul(new BN(50));
        // await instance.approve(accounts[0], amount);
        await instance.batchTransfer(accounts, value);

        balance1 = await instance.balanceOf(accounts[0]);
        console.log("balance0 = " + web3.utils.fromWei(balance1, 'ether'));

        balance1 = await instance.balanceView(accounts[1]);
        console.log("balance1 = " + web3.utils.fromWei(balance1, 'ether'));

        let allowance = await instance.allowance(accounts[0], instance.address);
        console.log("allowance = " + allowance);
        allowance = await instance.allowance(c_address,accounts[0]);
        console.log("allowance = " + allowance);

        let balance = await web3.eth.getBalance(accounts[1]);
        console.log("balanceEth0 = " + web3.utils.fromWei(balance, 'ether'));

        balance = await web3.eth.getBalance(c_address);
        console.log("balanceEthCon = " + web3.utils.fromWei(balance, 'ether'));

        // let transactionByHash = web3.eth.getTransaction("0x2e0eb643acd6bb8ac6e3f7750f9c7494c21632d7327ecc1e40433d7432cc623e");
        // console.log(JSON.stringify(transactionByHash));
        callback();
    } catch (e) {
        console.error(e.stack);
        callback()
    }
};

async function printBalance(account, instance) {
    console.log("---------------------------------------------------------------");
    console.log("Account: " + account);
    let balance = await instance.balanceOf(account);
    console.log("Balance: " + balance.div(frac).toString());
    console.log("---------------------------------------------------------------");
}
