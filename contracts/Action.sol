pragma solidity 0.4.17;


import './ActionManagerEnabled.sol';
import './Validee.sol';


contract Action is ActionManagerEnabled, Validee {
    uint8 public permission;

    function setPermission(uint8 perm) public validateActiveAction returns(bool) {
        permission = perm;
    }
}