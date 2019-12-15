
//监听代币交易事件

module.exports = async (callback) => {
    try {
        const MyToken = artifacts.require("MyToken");
        let instance = await MyToken.deployed();
        let BN = require("bn.js");
        let frac = new BN(10).pow(new BN(18));
        instance.Transfer().on('data', function (event) {
            console.log('-----------------');
            console.log('from', event.args.from);
            console.log('to', event.args.to);
            console.log('value', event.args.value.div(frac).toString());
        });

    } catch (e) {
        console.log("e = " + e.stack);
        callback(e)
    }
};