//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint256) public whoWavedHowMuch;
    address[] public wavers;

    constructor() payable {
        console.log("I AM THIRSTY FOR YOUR MESSAGE AND HELLO");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s",msg.sender,_message);
        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        whoWavedHowMuch[msg.sender] += 1; 
        if(whoWavedHowMuch[msg.sender] == 1)
        wavers.push(msg.sender);   

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(
            success, "Failed to withdraw money from contract"
        );
             
        console.log("%s has waved, %d times",msg.sender,whoWavedHowMuch[msg.sender]);
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