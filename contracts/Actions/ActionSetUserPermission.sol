pragma solidity 0.4.17;


import "../Action.sol";


contract ActionSetUserPermission is Action {
    function execute(address userAddr, uint8 perm) public onlyActionManager returns(bool) {
        require(userAddr != 0x0);
        address permdb = ContractProvider(CM).contracts("permissions");
        return PermValidator(permdb).setPermission(userAddr, perm);
    }
}