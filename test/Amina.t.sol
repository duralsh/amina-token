// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Amina} from "../src/Amina.sol";

contract AminaTest is Test {
    Amina amina;
    address recipient = address(0x123);
    address taxRecipient = address(0x456);

    function setUp() public {
        amina = new Amina("AminaToken", "AMN", 1000000, taxRecipient);
    }

    function testMint() public {
        uint256 mintAmount = 1000;
        amina.mint(recipient, mintAmount);
        assertEq(amina.balanceOf(recipient), mintAmount);
    }

    function testBurn() public {
        uint256 mintAmount = 1000;
        uint256 burnAmount = 500;
        amina.mint(recipient, mintAmount);
        amina.burn(recipient, burnAmount);
        assertEq(amina.balanceOf(recipient), mintAmount - burnAmount);
    }

    function testTaxOnTransfer() public {
        uint256 mintAmount = 1000;
        uint256 expectedTax = mintAmount * amina.taxPercentage() / 100;
        amina.mint(recipient, mintAmount);
        amina.transfer(taxRecipient, mintAmount);
        assertEq(amina.balanceOf(taxRecipient), expectedTax);
    }

    function testChangeTaxRecipient() public {
        address newTaxRecipient = address(0x789);
        amina.changeTaxRecipient(newTaxRecipient);
        assertEq(amina.taxAddress(), newTaxRecipient);
    }

    function testChangeTaxPercentage() public {
        uint256 newTaxPercentage = 5;
        amina.changeTaxPercentage(newTaxPercentage);
        assertEq(amina.taxPercentage(), newTaxPercentage);
    }

}
