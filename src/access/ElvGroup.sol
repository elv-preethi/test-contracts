// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "./ElvCmnRoles.sol";

/**
 * @dev Contract module that allows roles to represent set of group permissions.
 *
 * Roles can be granted and revoked dynamically via the {grantRole} and
 * {revokeRole} functions which emits {RoleGranted} and {RoleRevoked} event
 * respectively. Each role has an associated admin role, and only accounts
 * that have a role's admin role can call {grantRole} and {revokeRole}.
 * If calling account can revoke its permissions by calling {renounceRole} function.
 *
 * WARNING: The `DEFAULT_ADMIN_ROLE` is also its own admin: it has permission to
 * grant and revoke this role. Extra precautions should be taken to secure
 * accounts that have been granted it.
 */
contract ElvGroup is AccessControlEnumerable {
    constructor() {
        require(_msgSender() == tx.origin, "caller needs to be EOA");

        // Grant the contract deployer the default admin role
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

        // set `admin` role to the ``role``'s provided.
        // `DEFAULT_ADMIN_ROLE` is admin role for `GROUP_MANAGER_ROLE` and
        // `GROUP_MANAGER_ROLE` is admin role for `GROUP_USER_SEE_ROLE`,
        // `GROUP_USER_ACCESS_ROLE`, `GROUP_USER_EDIT_ROLE`
        _setRoleAdmin(ElvCmnRoles.GROUP_MANAGER_ROLE, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(
            ElvCmnRoles.GROUP_USER_SEE_ROLE, ElvCmnRoles.GROUP_MANAGER_ROLE
        );
        _setRoleAdmin(
            ElvCmnRoles.GROUP_USER_ACCESS_ROLE, ElvCmnRoles.GROUP_MANAGER_ROLE
        );
        _setRoleAdmin(
            ElvCmnRoles.GROUP_USER_EDIT_ROLE, ElvCmnRoles.GROUP_MANAGER_ROLE
        );
    }
}
