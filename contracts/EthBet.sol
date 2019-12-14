pragma solidity ^0.5.0;

import "./SafeMath.sol";

contract EthBet {

    using SafeMath for uint256;

    //构造函数,初始化函数
    constructor () public {}

    event BetAmountIncreased(uint256 amount);
    event BetFinished();


    //声明了 payable的函数的合约方法,可以接受ETH
    //回退函数 fallback ,
    function () external payable {
        require(msg.value > 0);
        emit BetAmountIncreased(msg.value);
    }

    //
    function submitResult(int r) public returns (bool) {

        //获取合约中的余额,address 类型可以直接取余额
        uint256 betAmount = address(this).balance;

        require(betAmount != 0);//判断余额不等于0

        if ( r == 1 + 1) {
            msg.sender.transfer(betAmount);//向发起者转账
            emit BetFinished();
            return true;
        } else {
            return false;
        }
    }
}
