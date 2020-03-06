const Balance = artifacts.require("Balance");

module.exports = async function(deployer) {
    let accounts = await web3.eth.getAccounts();
    await deployer.deploy(Balance, {from:accounts[1]});
};
