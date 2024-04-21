// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {OnlyPics} from "../src/OnlyPics.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();

        // Deploy OnlyPics
        OnlyPics onlyPics = new OnlyPics(0x000ef5F21dC574226A06C76AAE7060642A30eB74);
    }
}
