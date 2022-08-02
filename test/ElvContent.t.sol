//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/console2.sol";
import "../src/ElvContent.sol";

contract ElvContentTest is Test {
    ElvContent public elvContent;
    address deployer = address(0xDFDFDFDF);

    function setUp() public {
        // setting msg.sender and tx.origin to be EOA
        vm.prank(deployer, deployer);
        elvContent = new ElvContent();
    }

    function testUserRoles() public {
        address addr1 = address(0xDEADBEFF);
        address addr2 = address(0x8BADF00D);

        // change msg.sender and tx.origin to EOA (with DEFAULT_ADMIN_ROLE)
        vm.startPrank(deployer, deployer);
        // `deployer` grant see access to `addr1`
        elvContent.grantRole(ElvCmnRoles.USER_SEE_ROLE, addr1);
        // `deployer` grant edit access to `addr2`
        elvContent.grantRole(ElvCmnRoles.USER_EDIT_ROLE, addr2);
        vm.stopPrank();

        // change msg.sender and tx.origin to `addr1` to check `see` role enabled
        vm.prank(addr1, addr1);
        address owner = elvContent.getOwnerAddr();
        assertEq(owner, deployer, "method caller requires see role enabled");

        // change msg.sender and tx.origin to `addr2` to check `edit` role enabled
        vm.prank(addr2, addr2);
        bool ok = elvContent.updateRequest();
        assertEq(ok, true, "method caller requires edit role enabled");
    }

    function testGroupRoles() public {
        address grpDeployer = address(0xCAFEBABE);
        address manager = address(0xABADBABE);
        address addr1 = address(0xDEADBEFF);
        address addr2 = address(0x8BADF00D);

        // setting msg.sender and tx.origin to be EOA (with DEFAULT_ADMIN_ROLE)
        vm.startPrank(grpDeployer, grpDeployer);
        ElvGroup elvGrp = new ElvGroup();
        // grant `GROUP_MANAGER_ROLE` role to `manager` address.
        // `GROUP_MANAGER_ROLE` role is admin for
        //      - GROUP_USER_SEE_ROLE,
        //      - GROUP_USER_VIEW_ROLE,
        //      - GROUP_USER_ACCESS_ROLE
        elvGrp.grantRole(ElvCmnRoles.GROUP_MANAGER_ROLE, manager);
        vm.stopPrank();

        // manager sets the appropriate roles for the users
        vm.startPrank(manager, manager);
        elvGrp.grantRole(ElvCmnRoles.GROUP_USER_SEE_ROLE, addr1);
        elvGrp.grantRole(ElvCmnRoles.GROUP_USER_EDIT_ROLE, addr2);
        vm.stopPrank();

        // elvContent deployer (DEFAULT_ADMIN_ROLE) is the admin for `GROUP_ROLE`
        vm.prank(deployer, deployer);
        // elvGrp contract address is added as member to `GROUP_ROLE`
        elvContent.grantRole(ElvCmnRoles.GROUP_ROLE, address(elvGrp));

        // user with `GROUP_USER_SEE_ROLE` has access similar to `USER_SEE_ROLE`
        vm.prank(addr1, addr1);
        address owner = elvContent.getOwnerAddr();
        assertEq(owner, deployer, "method caller requires see role enabled");

        // user with `GROUP_USER_EDIT_ROLE` has access similar to `USER_EDIT_ROLE`
        vm.prank(addr2, addr2);
        bool ok = elvContent.updateRequest();
        assertEq(ok, true, "method caller requires edit role enabled");
    }
}
