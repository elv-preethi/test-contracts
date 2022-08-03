// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./access/ElvAccess.sol";
import "./access/ElvCmnRoles.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ElvContent is ElvAccess {
    address private _owner;
    string private objectHash = "TEST_HASH";

    event UpdateRequest(string objectHash);

    constructor() {
        _owner = _msgSender();
    }

    function checkUserOrGroupRole(bytes32 userRole, bytes32 groupRole)
        public
        view
        returns (bool)
    {
        require(_msgSender() == tx.origin, "caller needs to be EOA");

        if (hasRole(userRole, _msgSender())) {
            return true;
        }

        bytes32 userGrpRole;
        bool ok;
        (userGrpRole, ok) = hasGroupRole(_msgSender());
        if (ok) {
            require(
                groupRole == userGrpRole,
                string(
                    abi.encodePacked(
                        "AccessControl: account ",
                        Strings.toHexString(_msgSender()),
                        " is missing role ",
                        Strings.toHexString(uint256(groupRole)),
                        " has role ",
                        Strings.toHexString(uint256(userGrpRole))
                    )
                )
            );

            return true;
        }
        return false;
    }

    function hasRoleSee() public view {
        require(
            checkUserOrGroupRole(ElvCmnRoles.USER_SEE_ROLE, ElvCmnRoles.GROUP_USER_SEE_ROLE),
            string(
                abi.encodePacked(
                    "AccessControl: account ",
                    Strings.toHexString(_msgSender()),
                    " is missing role ",
                    Strings.toHexString(uint256(ElvCmnRoles.USER_SEE_ROLE)),
                    " or ",
                    Strings.toHexString(uint256(ElvCmnRoles.GROUP_USER_SEE_ROLE))
                )
            )
        );
    }

    function hasRoleAccess() public view {
        require(
            checkUserOrGroupRole(
                ElvCmnRoles.USER_ACCESS_ROLE, ElvCmnRoles.GROUP_USER_ACCESS_ROLE
            ),
            string(
                abi.encodePacked(
                    "AccessControl: account ",
                    Strings.toHexString(_msgSender()),
                    " is missing role ",
                    Strings.toHexString(uint256(ElvCmnRoles.USER_ACCESS_ROLE)),
                    " or ",
                    Strings.toHexString(uint256(ElvCmnRoles.GROUP_USER_ACCESS_ROLE))
                )
            )
        );
    }

    function hasRoleEdit() public view {
        require(
            checkUserOrGroupRole(
                ElvCmnRoles.USER_EDIT_ROLE, ElvCmnRoles.GROUP_USER_EDIT_ROLE
            ),
            string(
                abi.encodePacked(
                    "AccessControl: account ",
                    Strings.toHexString(_msgSender()),
                    " is missing role ",
                    Strings.toHexString(uint256(ElvCmnRoles.USER_EDIT_ROLE)),
                    " or ",
                    Strings.toHexString(uint256(ElvCmnRoles.GROUP_USER_EDIT_ROLE))
                )
            )
        );
    }

    function getOwnerAddr() public view returns (address) {
        hasRoleSee();
        return _owner;
    }

    function updateRequest() public returns (bool) {
        hasRoleEdit();
        objectHash = "NEW_HASH";
        emit UpdateRequest(objectHash);
        return true;
    }
}
