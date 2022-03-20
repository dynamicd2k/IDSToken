pragma solidity ^0.8.0;

import './IDSERC20.sol';
import './IDSERC721.sol';

contract IDSNFTMP is IDSERC20, IDSERC721{

    uint256 private _tokenIds;

    constructor(){
        admin= msg.sender;
    }

    function mintTokens(address to, uint256 amount) public returns(bool){
        mintToken(to, amount);
        return true;
    }

    function mintNFTs(address to) public returns(bool){
        _tokenIds +=1;
        mintNFT(to, _tokenIds);
        return true;
    }

    function buyNFT(address to, uint256 tokenId) public returns(bool){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        require(_balances[to]>=1, "ERC20Metadata: Insufficient Balance");

        transferToken(to,_owners[tokenId], 1);

        transferNFT(_owners[tokenId], to, tokenId);

        return true;
    }

    function sellNFT(uint256 tokenId) public returns(bool){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        _owners[tokenId]= admin;
        _balances[msg.sender] +=1;
        return true;
    }

    function getNFTOwner(uint256 tokenId) public view returns(address){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _owners[tokenId];
    }
}