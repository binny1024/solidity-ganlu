pragma solidity ^0.5.0;

import "./ERC20.sol";
//发币
contract MyToken is ERC20 {
    // 设置 ERC20代币的 名字
    string  public name = 'TTToken';//遵循 ERC20 标准
    // 代币的符号
    string  public symbol = 'TTT';//遵循 ERC20 标准
    //支持几位小数.如设置 2则支持两位小数
    uint8   public decimals = 18;//遵循 ERC20 标准
    //合约的版本号
    string  public version = '1.0.0';//遵循 ERC20 标准


    mapping(address => bool) _addressExists;
    address [] _tokenHolders;

    address payable creator;//默认持久化存储

    uint ratio = 100;

    /*
        实现 通过 ETH 购买 代币的功能:当该合约收到 N 个 ETH 的时候,会想发送方转 N * ratio个 代币
        该函数的触发条件:
        1,当外部账户或其他合约向该合约地址发送 ether 时；
        2,当外部账户或其他合约调用了该合约一个不存在的函数时.
    */
    function() external payable {
        // 发送方发过来的ETH  不能小于 0
        require(msg.value > 0);
        //代币个数
        uint256 totalValue = msg.value * ratio;
        //合约账户代币余额大于转账总数
        require(balanceOf(creator) > totalValue, '代币余额不足');
        //转出代币
        _transferToken(creator, msg.sender, totalValue);
        //转给自己 ETH
        //        creator.transfer(msg.value);
        creator.transfer(msg.value / 1 ether);
    }

    // 合约的构造函数
    constructor () public {

        // 初始化代币总量
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

    // 批量打币,
    function batchTransfer(address[] memory address_to, uint256 amount) public {
        uint256 length = address_to.length;
        uint256 amountTotal = amount * length;
        //打币总金额
        for (uint256 i = 0; i < length; i++) {
            require(balanceOf(creator) > amountTotal - amount * i);
            //            _mint(address_to[i], amount);
            transfer(address_to[i], amount);
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

    // 不加 view 关键字,返回的就不是预期的结果
    function balance(address addr) public returns (uint256){
        return balanceOf(addr);
    }
    //需要加 关键字view 才会返回 预期的结果 ,此处返回的是 addr 的余额
    function balanceView(address addr) public view returns (uint256){
        return balanceOf(addr);
    }
}
