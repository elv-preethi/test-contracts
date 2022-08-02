//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/console2.sol";
import "../src/ElvOwnable.sol";

contract ElvOwnableTest is Test {
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    ElvOwnable public elvOwnable;

    /**
     * @dev Expect event emitted when the contract is deployed
     * from : 0x0
     * to   : ElvOwnableTest contract (owner)
     */
    function setUp() public {
        vm.expectEmit(true, true, false, false);
        emit OwnershipTransferred(address(0), address(this));
        elvOwnable = new ElvOwnable();
    }

    /**
     * @dev Expect event emitted when contract is deployed
     * Test ownership can be transferred by only contract owner
     * from : ElvOwnableTest contract (owner)
     * to   : address(0x123)
     */
    function testTransferOwnershipByOwner() public {
        vm.expectEmit(true, true, false, false);
        emit OwnershipTransferred(address(this), address(0xDEADBEEF));
        elvOwnable.transferOwnership(address(0xDEADBEEF));
    }

    /**
     * @dev Test fails if transfer of ownership is done by others (not owner)
     * from : 0x0
     * to   : address(0x123)
     */
    function testFailTransferOwnershipNotByOwner() public {
        vm.prank(address(0));
        elvOwnable.transferOwnership(address(0xDEADBEEF));
    }

    /**
     * @dev Expect event emitted when contract is deployed
     * Test ownership can be renounced by only contract owner
     * from : ElvOwnableTest
     * to   : address(0)
     */
    function testRenounceOwnership() public {
        vm.expectEmit(true, true, false, false);
        emit OwnershipTransferred(address(this), address(0));
        elvOwnable.renounceOwnership();
    }

    /**
     * @dev Test fails if ownership is renounced by others (not owner)
     * from : address(0)
     */
    function testFailRenonunceOwnershipNotByOwner() public {
        vm.prank(address(0));
        elvOwnable.renounceOwnership();
    }
}
