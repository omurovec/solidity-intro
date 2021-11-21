pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Token is IERC20 {
    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256)) public allowances;

    uint256 public override totalSupply;

    string public name;
    string public symbol;

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;

        balances[msg.sender] = 100;
        totalSupply += 100;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);

        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);

        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = allowances[sender][msg.sender];
        require(currentAllowance >= amount, "Amount exceeds allowance");

        _approve(sender, msg.sender, currentAllowance - amount);

        return true;
    }

    function _transfer(address sender, address recipient, uint amount) internal {
        require(sender != address(0), "Sender cannot be the 0 address");
        require(recipient != address(0), "Recipient cannot be the 0 address");

        uint256 senderBalance = balances[sender];
        require(senderBalance >= amount);

        balances[sender] = senderBalance - amount;
        balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "Sender cannot be the 0 address");
        require(spender != address(0), "Recipient cannot be the 0 address");

        allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

}
