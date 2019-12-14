pragma solidity ^0.4.0;

import "./SafeMath.sol";
//批量转账
contract BatchTransferETH {
    function BatchTransferETH(){
        minter = msg.sender;
    }

    function batchTransfer(byte32[] addresses, uint amount) public {
        //获取合约中的余额,address 类型可以直接取余额
        uint256 betAmount = address(this).balance;

        require(betAmount > amount *addresses.length,"余额不足");
        //判断余额不等于0
        for (uint i = 0; i < addresses.length; i++) {
            betAmount = address(this).balance;

            addresses[i].transfer(amount);
        }
    }

}
