//监听代币交易事件

module.exports = async (callback) => {
    try {
        const MyToken = artifacts.require("MyToken");
        let instance = await MyToken.deployed();
        let BN = require("bn.js");
        let frac = new BN(10).pow(new BN(18));
        let events = await instance.getPastEvents('allEvents',{
                'fromBlock': 0,
                'toBlock': 'latest'
            },
            function (error) {
                console.log('error', error);
            });
        for (let i = 0; i < events.length; i++) {
            let event = events[i];
            console.log('-----------------------------------');
            console.log(JSON.stringify(event,null,4));
            // console.log('Transfer' + i);
            // console.log('from', event.args.from);
            // console.log('to', event.args.to);
            // console.log('value', event.args.value.div(frac).toString());
        }
        callback();
    } catch (e) {
        console.log("e = " + e.stack);
        callback(e)
    }
};