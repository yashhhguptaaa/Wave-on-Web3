//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    event NewWave(address indexed from, uint256 timestamp, string message);

    /*
      We will be using this below to help generate a random number
     */
    uint256 private seed;

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint256) public whoWavedHowMuch;
    address[] public wavers;

     /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("I AM THIRSTY FOR YOUR MESSAGE AND HELLO");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

        /*
         We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
        */
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved w/ message %s",msg.sender,_message);
        waves.push(Wave(msg.sender, _message, block.timestamp));


        whoWavedHowMuch[msg.sender] += 1; 
        if(whoWavedHowMuch[msg.sender] == 1)
        wavers.push(msg.sender);   

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);
        if(seed <= 50 ){
            console.log("%s won!",msg.sender);   
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(
                success, "Failed to withdraw money from contract"
            );
        }
             
        console.log("%s has waved, %d times",msg.sender,whoWavedHowMuch[msg.sender]);
        emit NewWave(msg.sender, block.timestamp, _message);

    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (address[] memory, uint256) {
        console.log("We have %d total waves!",totalWaves);
        for(uint i=0; i<wavers.length; i++) {
            console.log("Hey, MY address is %s",wavers[i]);
        }
        return (wavers,totalWaves);
    }
}   