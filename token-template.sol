// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Token {
    uint public totalSupply;
    string public name = "excelcium";
    string public symbol = "exc";
    uint8 public decimals = 18;

    mapping(address => uint256) balance;

    function balanceOf(address _owner) external view returns(uint _balance) {
        _balance = balance[_owner];
    }

    constructor() {
        totalSupply = 1000*10**18;
        balance[msg.sender] = totalSupply;
    }
}