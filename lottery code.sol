// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Lottery{

    address payable[] public players; // payabale has been added because these addresses can transfer money.
    address payable private admin;

    constructor(){
        admin=payable(msg.sender); //specifies the one who deployed the contract

    }

    receive() external payable {
        require(msg.value==1 ether);
        require(msg.sender!=admin);
        players.push(payable(msg.sender)); 
        //The condition for entry is 1 ether. Also, the admin cannot login.
    } 


    function getBalance() public view returns(uint){
        return address(this).balance; //Returns the balance of the contract.

    }

    function random() internal view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }
    
    function pickWinner() public {
        require(msg.sender==admin, "you are not admin");
        require(players.length>=5);

    //Just admin can select winner

    address payable winner;
    winner=players[random()%players.length]; //winner is calculated

    winner.transfer(getBalance()); //transfer all ether to winner address
    }
}
