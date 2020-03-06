pragma solidity ^0.5.0;

contract SimpleStorage {
    constructor () public {

    }
    uint256 storedData;

    function set(uint256 x) public {
        require(x>10,'the number is too low');
        storedData = x;
    }

    function get() public view returns (uint256) {
        return storedData;
    }
}
