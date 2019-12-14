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
   truffle migrate
   ```
6. Run a demo script

    ```
    truffle exec mytoken.js
    ```
