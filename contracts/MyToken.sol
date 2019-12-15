pragma solidity ^0.5.0;

import "./ERC20.sol";
//发币
contract MyToken is ERC20 {

    string  public name = 'TTToken';
    uint8   public decimals = 18;
    string  public symbol = 'TTT';
    string  public version = '1.0.0';


    mapping(address => bool) _addressExists;
    address [] _tokenHolders;

    address payable creator;//默认持久化存储

    uint ratio = 100;

    /*
        实现 通过 ETH 购买 代币的功能

        当该合约收到 N 个 ETH 的时候,会想发送方转 N * ratio个 代币


    */
    function() external payable {
        require(msg.value > 0);// 发送方发过来的ETH  不能小于 0
        uint256 totalValue = msg.value * ratio;
        require(balanceOf(creator) > totalValue);
        _transfer(creator, msg.sender, totalValue);
        creator.transfer(msg.value);
    }

    constructor () public {
        _mint(msg.sender, 100000000 * 10 ** 18);
        creator = msg.sender;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function getDecimals() public view returns (uint8) {
        return decimals;
    }

    function getSymbol() public view returns (string memory) {
        return symbol;
    }

    function getVersion() public view returns (string memory) {
        return version;
    }

    function inflate() public {
        uint256 amount = 1000000 * 10 ** 18 / _tokenHolders.length;

        uint256 length = _tokenHolders.length;
        for (uint256 i = 0; i < length; i++) {
            if (balanceOf(_tokenHolders[i]) != 0) {
                _mint(_tokenHolders[i], amount);
            }
        }
    }

    function batchTransfer(address[] memory address_to, uint256 amount) payable public {
        uint256 amountTotal = amount * address_to.length;
        uint256 length = address_to.length;
        for (uint256 i = 0; i < length; i++) {
            require(balanceOf(creator) > amountTotal - amount * i);
            _mint(address_to[i], amount);
        }
    }

    // 转账时,缓存持有者
    function transfer(address recipient, uint256 amount) public returns (bool) {

        if (balanceOf(recipient) == 0 && !_addressExists[recipient]) {
            _addressExists[recipient] = true;
            _tokenHolders.push(recipient);
        }
        return super.transfer(recipient, amount);
    }
}
