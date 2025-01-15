// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTContract is ERC721 {
    uint256 public tokenCounter;
    mapping(uint256 => uint256) public tokenPrices;

    constructor() ERC721("SampleNFT", "SNFT") {
        tokenCounter = 1;
    }

    function mintNFT(address _to, uint256 _price) public returns (uint256) {
        uint256 tokenId = tokenCounter;
        _safeMint(_to, tokenId);
        tokenPrices[tokenId] = _price;
        tokenCounter++;
        return tokenId;
    }

    function buyNFT(uint256 _tokenId) public payable {
        require(msg.value >= tokenPrices[_tokenId], "Insufficient payment");
        address tokenOwner = ownerOf(_tokenId);
        require(tokenOwner != address(0), "Invalid token ID");

        // Transfer NFT to buyer
        _transfer(tokenOwner, msg.sender, _tokenId);

        // Pay the original owner
        payable(tokenOwner).transfer(msg.value);

        // Reset price
        tokenPrices[_tokenId] = 0;
    }
}