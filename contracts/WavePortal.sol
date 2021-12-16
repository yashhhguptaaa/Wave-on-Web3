//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    mapping(address => uint256) public whoWavedHowMuch;
    address[] public wavers;

    constructor() {
        console.log("Yo yo, I am a contract and I am a smart");
    }

    function wave() public {
        totalWaves += 1;
        whoWavedHowMuch[msg.sender] += 1; 
        if(whoWavedHowMuch[msg.sender] == 1)
        wavers.push(msg.sender);   
             
        console.log("%s has waved, %d times",msg.sender,whoWavedHowMuch[msg.sender]);
    }

    function getTotalWaves() public view returns (address[] memory, uint256) {
        console.log("We have %d total waves!",totalWaves);
        for(uint i=0; i<wavers.length; i++) {
            console.log("Hey, MY address is %s",wavers[i]);
        }
        return (wavers,totalWaves);
    }
}   