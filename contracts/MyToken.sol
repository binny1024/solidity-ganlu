pragma solidity ^0.5.0;

import "./ERC20.sol";
//发币
contract MyToken is ERC20 {

    string  public name = 'TTToken';
    uint8   public decimals = 18;
    string  public symbol = 'TTT';
    string  public version = '1.0.0';




    struct KeyValue {uint key;uint value;}

    mapping(address => bool) _addressExists;
    address [] _tokenHolders;
    function inflate() public {
        uint256 amount = 1000000 * 10 ** 18 / _tokenHolders.length;

        for (uint256 i = 0; i < _tokenHolders.length; i++) {
            if (balanceOf(_tokenHolders[i]) != 0) {
                _mint(_tokenHolders[i], amount);
            }
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
    constructor () public {
        _mint(msg.sender, 100000000 * 10 ** 18);
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

}
