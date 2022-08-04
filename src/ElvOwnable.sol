// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/access/ownable.sol";

contract ElvOwnable is Ownable {
    /**
     * @dev Kills contract; send remaining funds back to owner
     */
    function kill() public onlyOwner {
        address _owner = owner();
        selfdestruct(payable(_owner));
    }
}
