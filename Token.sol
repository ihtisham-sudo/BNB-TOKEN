// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Token{
    mapping(address=>uint) public balances;
    mapping(address => mapping(address=>uint)) public allowance;
    uint public totalAmount = 10 ** 18;
    string public name = "$HAM";
    string public symbol = "TKN";
    uint public decimal = 18;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor (){
        balances[msg.sender] = totalAmount;
    }

    function balanceof(address owner)public view returns(uint){
        return balances[owner];
    }

    function transfer(address to, uint value) public returns (bool){
        require(balanceof(msg.sender)>= value, "Balance too low");
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) public returns (bool){
        require(balanceof(from) >= value, "Balance too low");
        require(allowance[from][msg.sender]>= value, "allowance too low");
        balances[to]+=value;
        balances[from]-=value;
        return true;
    }
    
    function approve(address spender, uint value) public returns(bool){
        allowance [msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }


}