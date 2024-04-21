// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/StorageSlot.sol";

contract OnlyPics is ERC1155, Ownable {
    constructor(address initialOwner) ERC1155("OnlyPics") Ownable(initialOwner) {}

    mapping(uint256 => uint256) public deadlines;
    mapping(uint256 => uint256) public tokenSupply;

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, bytes memory data)
        public payable
    {
        
        //price increases with the number of tokens minted
        uint256 multiplier;
        if(tokenSupply[id] == 0){
            multiplier = 1;
        } else{
            multiplier = tokenSupply[id]/100;
        }
        uint256 price = 0.00001 ether * multiplier;
        if (msg.value < price) {
            revert("Insufficient funds");
        }
        uint256 amount = msg.value / price;

        tokenSupply[id] += amount;

        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }
}