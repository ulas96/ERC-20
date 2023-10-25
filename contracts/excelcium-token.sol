//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Excelcium is ERC20 {
    uint public _initial_supply = (10**8) * (10**18);
    constructor() ERC20("Excelcium", "EXC") {
        _mint(msg.sender, _initial_supply);
    }
}


