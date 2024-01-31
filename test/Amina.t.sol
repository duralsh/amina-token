// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Amina} from "../src/Amina.sol";

contract AminaTest is Test {
    Amina public amina_token;

    function setUp() public {
        amina_token = new Amina("AMINA", "AMN", 10000000000000000000000000 ether, address(0x1ef58E6dE15e03b4C3B31C49af426E3328c5aEA5));
    }

    function test_Increment() public {
        amina_token.mint(address(this), 10000000000000000000000000 ether);
        amina_token.transfer(address(0x1ef58E6dE15e03b4C3B31C49af426E3328c5aEA5), 1 ether);

    }

    function testFuzz_SetNumber(uint256 x) public {
       
    }
}
