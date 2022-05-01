pragma solidity ^0.8.0;

import './IDSERC20.sol';
import './IDSERC721.sol';

contract IDSNFTMP is IDSERC20, IDSERC721{

    uint256 private _tokenIds;

    mapping(uint256=>bool) internal _auctionStatus;

    mapping(uint256=>uint256) internal _auctionValue;

    mapping(uint256=>bool) internal _staked;

    mapping(uint256=>uint256) internal _releaseTime;

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
        _auctionStatus[_tokenIds]= false;
        _staked[_tokenIds]= false;
        return true;
    }

    function auctionNFT(uint256 tokenId, uint256 value) public returns(bool){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        require(getNFTOwner(tokenId)==msg.sender, 'Only owner can set NFT for auction');
        _auctionStatus[tokenId]= true;
        _auctionValue[tokenId]= value;
        return true;
    }

    function buyNFT(address to, uint256 tokenId) public returns(bool){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        require(_balances[to]>=1, "ERC20Metadata: Insufficient Balance");
        require(_auctionStatus[tokenId]== true, "Token not available to be purchased");
        require(_staked[tokenId]== false, "Token staked, not available to be purchased");
        transferToken(to,_owners[tokenId], _auctionValue[tokenId]);
        transferNFT(_owners[tokenId], to, tokenId);
        return true;
    }

    function sellNFT(uint256 tokenId) public returns(bool){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        require(_staked[tokenId]== false, "Token staked, not available to be purchased");
        _balances[msg.sender] +=1;
        _owners[tokenId]= admin;
        return true;
    }

    function stakeNFT(uint256 tokenId, uint256 lockPreiodInDays) public returns(bool){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        require(getNFTOwner(tokenId)== msg.sender,"Only owner");
        _releaseTime[tokenId]=block.timestamp+lockPreiodInDays*24*60*60*1000;
        _staked[tokenId]= true;
        return true;
    }

    function release(uint256 tokenId) public returns(bool){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        require(block.timestamp>=releaseTime(tokenId), "TokenTimelock: current time is before release time");
        _staked[tokenId]=false;
        return true;
    }
    function getNFTOwner(uint256 tokenId) public view returns(address){
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _owners[tokenId];
    }

    function releaseTime(uint256 tokenId) public view returns (uint256) {
        return _releaseTime[tokenId];
    }
}