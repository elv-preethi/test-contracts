// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "./ElvGroup.sol";
import "./ElvCmnRoles.sol";

// ElvAccess contract module allows Role based access control
// for individual users and group users.
contract ElvAccess is AccessControlEnumerable {
    constructor() {
        require(_msgSender() == tx.origin, "caller needs to be EOA");

        // Grant the contract deployer the default admin role
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

        /* set `admin` role to the ``role``'s provided.
         * `DEFAULT_ADMIN_ROLE` is admin role for `USER_SEE_ROLE`,
         * `USER_ACCESS_ROLE`, `USER_EDIT_ROLE`, `GROUP_ROLE`.
         *
         * The `USER_SEE_ROLE`,`USER_ACCESS_ROLE`, `USER_EDIT_ROLE`
         * members are individual users whereas
         * the `GROUP_ROLE` members are ElvGroup contract address.
         */
        _setRoleAdmin(ElvCmnRoles.USER_SEE_ROLE, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(ElvCmnRoles.USER_ACCESS_ROLE, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(ElvCmnRoles.USER_EDIT_ROLE, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(ElvCmnRoles.GROUP_ROLE, DEFAULT_ADMIN_ROLE);
    }

    // hasGroupRole checks if the provided account is
    // having predefined set of group roles and
    // returns the `role`
    function hasGroupRole(address account)
        public
        view
        virtual
        returns (bytes32, bool)
    {
        uint256 grpRoleCount = getRoleMemberCount(ElvCmnRoles.GROUP_ROLE);
        for (uint256 i = 0; i < grpRoleCount; i++) {
            address grpAddr = getRoleMember(ElvCmnRoles.GROUP_ROLE, i);
            ElvGroup elvGrp = ElvGroup(grpAddr);
            bytes32[4] memory grpRoles = ElvCmnRoles.getGroupRoles();
            for (uint256 j = 0; j < grpRoles.length; j++) {
                if (elvGrp.hasRole(grpRoles[j], account)) {
                    return (grpRoles[j], true);
                }
            }
        }

        return (bytes32(0), false);
    }
}
