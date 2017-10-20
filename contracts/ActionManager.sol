pragma solidity 0.4.17;


import './ContractManagerEnabled.sol';
import './Interfaces/ContractProvider.sol';
import './Interfaces/ActionDbProvider.sol';
import './Interfaces/PermValidator.sol';


contract ActionManager is ContractManagerEnabled {

    address public activeAction;
    bool public locked;
    uint8 public permToUnlock = 255;

    event ActionCall(
        address indexed caller,
        bytes32 indexed actionName,
        uint256 blockNumber,
        bool indexed success,
        uint32 messageCode
        );

    function execute(bytes32 actionName, bytes data) public returns(bool) {
        address actiondb = ContractProvider(CM).contracts("actiondb");
        if (actiondb == 0x0) {
            ActionCall(msg.sender, actionName, block.number, false, 500);
            return false;
        }

        address actionAddr = ActionDbProvider(actiondb).actions(actionName);
        if (actionAddr == 0x0) {
            ActionCall(msg.sender, actionName, block.number, false, 404);
            return false;
        }

        address perms = ContractProvider(CM).contracts("permissions");
        if (perms == 0x0) {
            bool accessGranted = true;
        } else {
            accessGranted = PermValidator(perms).validate(msg.sender, actionAddr);
        }
        if (!accessGranted) {
            ActionCall(msg.sender, actionName, block.number, false, 401);
            return false;
        }

        // after full validation, set action that is allowed to run as activeAction
        activeAction = actionAddr;
        bool result = actionAddr.call(data);
        activeAction = 0x0;

        ActionCall(msg.sender, actionName, block.number, result, 200);
        return result;
    }

    /**
     * @dev when you deploy new contracts or make changes you don't want users to do transactions
     */
    function lock() public returns(bool) {
        if (msg.sender != activeAction || locked) {
            return false;
        }
        locked = true;
        return true;
    }

    function unlock() public returns(bool) {
        if (msg.sender != activeAction || !locked) {
            return false;
        }
        locked = false;
        return true;
    }
}
