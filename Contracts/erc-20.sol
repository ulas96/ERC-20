pragma solidity ^0.8.0;

import "./ERC20.sol";

contract StakedToken is ERC20 {
    ERC20 public token;
    uint256 public stakingFee;
    uint256 public unstakingFee;
    mapping(address => uint256) public stakedBalances;
    mapping(address => uint256) public stakedTimestamps;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalSupply,
        uint256 _stakingFee,
        uint256 _unstakingFee,
        address _token
    ) ERC20(_name, _symbol, _decimals, _totalSupply) {
        stakingFee = _stakingFee;
        unstakingFee = _unstakingFee;
        token = ERC20(_token);
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        uint256 fee = (_amount * stakingFee) / 100;
        uint256 stakedAmount = _amount - fee;
        stakedBalances[msg.sender] += stakedAmount;
        stakedTimestamps[msg.sender] = block.timestamp;
        _mint(msg.sender, stakedAmount);
        _mint(owner(), fee);
    }

    function unstake(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        require(stakedBalances[msg.sender] >= _amount, "Insufficient balance");
        require(block.timestamp >= stakedTimestamps[msg.sender] + 1 days, "Must wait 1 day before unstaking");
        uint256 fee = (_amount * unstakingFee) / 100;
        uint256 unstakedAmount = _amount - fee;
        stakedBalances[msg.sender] -= _amount;
        token.transfer(msg.sender, unstakedAmount);
        _burn(msg.sender, _amount);
        _mint(owner(), fee);
    }
}
