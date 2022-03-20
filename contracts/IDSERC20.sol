pragma solidity ^0.8.0;

import "@openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract IDSERC20 is ERC20 {

    address admin;

    constructor (string _totalSupply) ERC20['IDSERC20','IDS']{
        admin=msg.sender;
        _mint(msg.sender, 1000000*decimals());                  //totalSupply- 1000000
    }

    //
    function returntokenName() public view returns (string){
        name();
    }

    function returnTokenSymbol() public view returns(string){
        symbol();
    }

    function totalSupply() public view returns(uint256{
        totalSupply();
    }
    function balanceOf(address account) public view returns(uint256{
        balanceOf(account);
    }
    function transfer(address to, uint256 amount) public payable retuns(bool){
        address from = msg.sender;
        _transfer(from, to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public payable returns(bool){
        _transfer(from, to, amount);
    }

    function burnToken(address account, uint256 amount) internal returns(uint256){
        require(msg.sender== admin || msg.sender == account, 'Admin or owner can burn tokens');
        _burn(account, amount);
    }
}