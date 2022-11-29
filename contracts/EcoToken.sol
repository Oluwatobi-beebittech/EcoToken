// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EcoToken is ERC20, ERC20Burnable, Pausable, Ownable {
    mapping(address => uint256) private _earnedTokens;
    event EarnedToken(
        string paymentType, 
        address receiver, 
        uint256 amount, 
        string additionalNote, 
        string itemName, 
        string itemWeight
    );
    
    uint256 private _price;

    constructor(uint256 initialSupply) ERC20("EcoToken", "ECO") {
        _mint(_msgSender(), initialSupply * (10**uint256(decimals())));
    }

    function decimals() public pure override returns (uint8) {
        return 2;
    }

    function price() public view returns (uint256) {
        return _price;
    }

    function setPrice(uint256 priceInWei) public onlyOwner {
        _price = priceInWei;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function getEarnedTokenBalance() public view returns (uint256){
        return _earnedTokens[_msgSender()];
    }

    function mint(uint256 amount) public onlyOwner {
        _mint(_msgSender(), amount);
    }

    function reward(
        address rewardRecipient, 
        string calldata paymentType, 
        uint256 amount, 
        string calldata additionalNote, 
        string calldata itemName, 
        string calldata itemWeight
    ) public onlyOwner
    {
        require(transfer(rewardRecipient, amount), "Could not transfer rewards");
        _earnedTokens[rewardRecipient] += amount;
        emit EarnedToken(paymentType, rewardRecipient, amount, additionalNote, itemName, itemWeight);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function burn(uint256 amount) public override {
        uint256 earnedAccountBalance = _earnedTokens[_msgSender()];
        require(amount <= earnedAccountBalance, "Cannot burn tokens not earned");
        _earnedTokens[_msgSender()] = earnedAccountBalance - amount; 
        _burn(_msgSender(), amount);
    }
}
