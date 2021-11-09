// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {

    address owner;

    uint256 totalSupply = 10_000;

    event SupplyChange(uint256 supply);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "Sender is not the owner.");
        _;
    }

    function getSupply() external view returns (uint256) {
        return totalSupply;
    }

    function increaseSupply() public onlyOwner {
        totalSupply += 1000;
        emit SupplyChange(totalSupply);
    }
}

