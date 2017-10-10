pragma solidity 0.4.17;


import '../Action.sol';


contract ActionAddAction is Action {
    function execute(bytes32 name, address addr) public onlyActionManager returns(bool) {
        address actiondb = ContractProvider(CM).contracts("actiondb");
        assert(actiondb != 0x0);
        return ActionDbProvider(actiondb).addAction(name, addr);
    }
}
