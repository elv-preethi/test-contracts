// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ElvCmnRoles {
    // ============ User roles ============== //
    bytes32 public constant USER_SEE_ROLE = keccak256("USER_SEE_ROLE");
    bytes32 public constant USER_ACCESS_ROLE = keccak256("USER_ACCESS_ROLE");
    bytes32 public constant USER_EDIT_ROLE = keccak256("USER_EDIT_ROLE");

    // GROUP_ROLE contains group contract address as members
    bytes32 public constant GROUP_ROLE = keccak256("GROUP_ROLE");

    // ============ Group roles ============= //
    bytes32 public constant GROUP_MANAGER_ROLE = keccak256("GROUP_MANAGER_ROLE");
    bytes32 public constant GROUP_USER_SEE_ROLE =
        keccak256("GROUP_USER_SEE_ROLE");
    bytes32 public constant GROUP_USER_ACCESS_ROLE =
        keccak256("GROUP_USER_ACCESS_ROLE");
    bytes32 public constant GROUP_USER_EDIT_ROLE =
        keccak256("GROUP_USER_EDIT_ROLE");

    function getGroupRoles() internal pure returns (bytes32[4] memory) {
        return [
            GROUP_MANAGER_ROLE,
            GROUP_USER_SEE_ROLE,
            GROUP_USER_ACCESS_ROLE,
            GROUP_USER_EDIT_ROLE
        ];
    }
}
