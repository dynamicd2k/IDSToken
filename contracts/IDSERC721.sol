pragma solidity ^0.8.0;

import "@openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin-solidity/contracts/utils/Counters.sol";

contract IDSERC721 is ERC721{
    using Counters for Counters.counter;
    Counters.counter private tokenIds;
    constructor (string _totalSupply) ERC20['IDSERC20','IDS']{

        function mintToken(address account , string memory tokenURI) public retuns (uint256){
            tokenIds.increment();
            uint256 newTokenId = tokenIds.current();
            _mint(account, newTokenId);
            return newTokenId;
        }

        function transfer(address to, uint256 tokenId) public returns(bool){
            require(owner(tokenId)==msg.sender, 'Only owner of token can transfer token');
            transferFrom(msg.sender, to, tokenId);
        }

        function checkBalance(address account) public view returns(uint256){
            balanceOf(account);
        }

        function owner(uint256 tokenId) public view returns(address){
            ownerOf(tokenId);
        }

        function checkSymbol() public view returns (string){
            symbol();
        }
        function checkTokenURI(uint256 tokenId) public view returns(string memory){
            tokenURI(tokenId);
        }

        function approveTransfer(address to, uint256 tokenId) internal returns(bool){
            require(owner(tokenId)==msg.sender, 'Only token owner can approve transfer');
            _approve(to, tokenId);
            return true;
        }
        
        function burn(tokenId) internal returns(bool) {
            _burn(tokenId);
        }

    }
}