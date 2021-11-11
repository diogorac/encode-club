// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    struct Payment {
        uint256 amount;
        address recipient;
    }

    address owner;
    uint256 totalSupply = 10_000;

    mapping(address => uint256) public balance;
    mapping(address => Payment[]) public payments;

    event SupplyChange(uint256 supply);
    event Transfer(uint256 amount, address recipient);

    constructor() {
        owner = msg.sender;
        balance[msg.sender] = totalSupply;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Sender is not the owner.");
        _;
    }

    function transfer(uint256 _amount, address _recipient) external {
        require(balance[msg.sender] >= _amount, "Not enough balance");

        balance[_recipient] += _amount;
        balance[msg.sender] -= _amount;

        payments[msg.sender].push(
            Payment({amount: _amount, recipient: _recipient})
        );

        emit Transfer(_amount, _recipient);
    }

    function getSupply() external view returns (uint256) {
        return totalSupply;
    }

    function increaseSupply() external onlyOwner {
        totalSupply += 1000;
        emit SupplyChange(totalSupply);
    }
}
