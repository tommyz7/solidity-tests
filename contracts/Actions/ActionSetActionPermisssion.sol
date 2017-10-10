pragma solidity 0.4.17;


import '../Action.sol';


contract ActionSetActionPermisssion is Action {
    function execute(bytes32 name, uint8 perm) public onlyActionManager returns(bool) {
        address actiondb = ContractProvider(CM).contracts("actiondb");
        address action = ActionDbProvider(actiondb).actions(name);
        return Action(action).setPermission(perm);
    }
}