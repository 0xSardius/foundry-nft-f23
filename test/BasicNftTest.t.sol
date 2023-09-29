// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant OBJECT_PERMANENCE = "https://ipfs.io/ipfs/QmSPf9FVb86gUPgbZx2fER4HJCcx3FCB5DCQ9V9yg6E8J8?filename=No%20object%20Permanence.jpg";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Doggie";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(OBJECT_PERMANENCE);
        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(OBJECT_PERMANENCE)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }

}