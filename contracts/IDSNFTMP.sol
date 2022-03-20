pragma solidity ^0.8.0;

contract IDSNFTMP is IDSERC20 IDSERC721{

    constructor(){
        admin msg.sender;
    }

    function buyToken(){

    }

    function sellToken(){

    }
    function getOwner(){

    }
    function requestTrade(){
        //pay in IDSECERC20
        //Exchange and move IDSECERC721
    }
}