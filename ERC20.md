ERC20标准涵盖了哪些内容？
我们可以在https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md查看ERC20代币的标准API。

## Method
在Method目录下面我们可以看到一些方法，所有的ERC20代币都是按照下面这些方法来定义的。下面我们讲解一下每个方法的作用。

1,`name`
```
function name() constant returns (string name) 
```
返回string类型的ERC20代币的名字，例如：StatusNetwork

2,`symbol`
```
function symbol() constant returns (string symbol)
```
返回string类型的ERC20代币的符号，也就是代币的简称，例如：SNT。

3,`decimals`
```
function decimals() constant returns (uint8 decimals)
```
支持几位小数点后几位。如果设置为3。也就是支持0.001表示。

4,`totalSupply`
```
function totalSupply() constant returns (uint256 totalSupply)
```
发行代币的总量，可以通过这个函数来获取。所有智能合约发行的代币总量是一定的，totalSupply必须设置初始值。如果不设置初始值，这个代币发行就说明有问题。

5,`balanceOf`
```
function balanceOf(address _owner) constant returns (uint256 balance)
```
输入地址，可以获取该地址代币的余额。

6,`transfer`
```
function transfer(address _to, uint256 _value) returns (bool success)
```
调用transfer函数将自己的token转账给_to地址，_value为转账个数

7,`approve`
```
function approve(address _spender, uint256 _value) returns (bool success)
```
批准_spender账户从自己的账户转移_value个token。可以分多次转移。

8,`transferFrom`
```
function transferFrom(address _from, address _to, uint256 _value) returns (bool success)
```
与approve搭配使用，approve批准之后，调用transferFrom函数来转移token。

9,`allowance`
```
function allowance(address _owner, address _spender) constant returns (uint256 remaining)
```
返回_spender还能提取token的个数。

`approve`、`transferFrom`及`allowance`解释：

账户A有1000个ETH，想允许B账户随意调用100个ETH。A账户按照以下形式调用approve函数approve(B,100)。

当B账户想用这100个ETH中的10个ETH给C账户时，则调用transferFrom(A, C, 10)。

这时调用allowance(A, B)可以查看B账户还能够调用A账户多少个token。

## Events
1,`Transfer`
```
event Transfer(address indexed _from, address indexed _to, uint256 _value)
```
当成功转移token时，一定要触发Transfer事件

2,`Approval`
```
event Approval(address indexed _owner, address indexed _spender, uint256 _value)
```
当调用approval函数成功时，一定要触发Approval事件

作者：沙漠中的猴
链接：https://www.jianshu.com/p/a5158fbfaeb9
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。