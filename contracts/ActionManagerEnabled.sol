pragma solidity 0.4.17;


import './ContractManagerEnabled.sol';


contract ActionManagerEnabled is ContractManagerEnabled {

    event UnauthorisedCall(
        address indexed caller,
        address indexed contractCalled,
        uint256 indexed blockNumber
        );

    modifier onlyActionManager() {
        require(CM != 0x0);
        address actionManager = ContractProvider(CM).contracts("actionmanager");
        if (msg.sender == actionManager) {
            _;
        } else {
            UnauthorisedCall(msg.sender, this, block.number);
        }
    }

    /**
     * Functional version of modifier onlyActionManger - when return value is needed
     * @return Boolean true if success
     */
    function isActionManager() internal returns(bool result) {
        if (CM != 0x0) {
            address actionManager = ContractProvider(CM).contracts("actionmanager");
            result = msg.sender == actionManager;
            if (!result) {
                UnauthorisedCall(msg.sender, this, block.number);
            }
        }
    }
}