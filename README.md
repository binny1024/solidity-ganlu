### Solidity Course

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
   
