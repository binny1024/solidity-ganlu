const BN = require("bn.js");
module.exports = async function (callback) {
    try {
        let frac = new BN(106);
        // frac = frac.pow(new BN(18));
        let SimpleStorage = artifacts.require("SimpleStorage");
        let tokenInstance = await SimpleStorage.deployed();
        // console.log("tokenInstance = "+JSON.stringify(tokenInstance));
        await tokenInstance.set(frac);
        let data = await  tokenInstance.get();

        console.log('data =' + JSON.stringify(data));

        callback()
    } catch (e) {
        callback(e);
    }
};
