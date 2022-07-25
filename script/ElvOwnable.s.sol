// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/ElvOwnable.sol";

contract ElvOwnableScript is Script {
    function setUp() public {}

    function run() public {

        vm.startBroadcast();
        ElvOwnable elvOwnable = new ElvOwnable();
        vm.stopBroadcast();

        address ownerAddr = elvOwnable.owner();
        console.log("Before Kill process, owner:", vm.toString(ownerAddr));

        vm.startBroadcast();
        elvOwnable.kill();
        vm.stopBroadcast();

        ownerAddr = elvOwnable.owner();
        console.log("After Kill process, owner:", vm.toString(ownerAddr));
    }
}
