### Solidity Course

ssh://git@git.dev.yuanben.org:7999/com/solidity-course.git

1. Install and start [Ganache](https://www.trufflesuite.com/ganache) as a local Ethereum test node.
2. Install truffle

    ``` Shell
    npm install -g truffle
    ```
   
3. Install Nodejs dependencies

    ``` Shell
    npm install
    ```
   
4. Compile contracts

    ```
    truffle compile
    ```
   带参数 `--all`
   ```
    truffle compile --all
   ```
5. Run migrations

    ```
    truffle migrate
    ```
   带参数 `--reset`
   ```
   truffle migrate --reset
   ```
   输出到文件
   ```
    sudo truffle migrate --reset >> ./log/migrate.log && echo "--------add payable----" >>./log/migrate.log 
   ```
   重新部署,就是发一个新的合约,旧的合约还在链上
6. Run a demo script,执行合约调用

    ```
    truffle exec mytoken.js
    ```
   
  7. 获取所有的账户
   ```javascript
    let accounts = await web3.eth.getAccounts();
   ```
   8 . 事件及订阅
   event :
   
   ```javascript
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
    ```
    抛出事件:
    ```javascript
    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }
    ``` 
   订阅:
   ``` 
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
   ```
   
   ```javascript
    //获取所有区块信息
    
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
    ```