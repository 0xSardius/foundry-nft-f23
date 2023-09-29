//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant OBJECT_PERMANENCE = "https://ipfs.io/ipfs/QmSPf9FVb86gUPgbZx2fER4HJCcx3FCB5DCQ9V9yg6E8J8?filename=No%20object%20Permanence.jpg";
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(OBJECT_PERMANENCE);
        vm.stopBroadcast();
    }
}