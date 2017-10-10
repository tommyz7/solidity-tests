pragma solidity 0.4.17;


import './Validee.sol';
import './Interfaces/ContractProvider.sol';
import './Interfaces/ActionManagerProvider.sol';
import './Interfaces/ActionProvider.sol';


contract PermissionDB is Validee {

    // caller address => permisions value
    mapping(address => uint8) public perms;

    function validate(address caller, address actionAddr) public returns(bool) {
        address am = ContractProvider(CM).contracts("actionmanager");
        bool locked = ActionManagerProvider(am).locked();
        uint8 permToUnlock = ActionManagerProvider(am).permToUnlock();
        uint8 userPerm = perms[caller];
        if (locked && userPerm < permToUnlock) {
            return false;
        }
        uint8 actionRequiredPerm = ActionProvider(actionAddr).permission();
        return userPerm >= actionRequiredPerm;
    }

    function setPermission(address addr, uint8 perm)
            public
            validateActiveAction
            returns(bool) {
        perms[addr] = perm;
        return true;
    }
}