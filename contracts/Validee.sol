pragma solidity 0.4.17;


import './ContractManagerEnabled.sol';
import './ActionManager.sol';
import './Interfaces/ActionManagerProvider.sol';


contract Validee is ContractManagerEnabled {

    event ValidationError(
        address indexed caller,
        address indexed calledContract,
        address indexed activeActionAddr,
        uint256 blockNumber
        );

    modifier validateActiveAction() {
        require(CM != 0x0);
        address am = ContractProvider(CM).contracts("actionmanager");
        assert(am != 0x0);
        address aa = ActionManagerProvider(am).activeAction();
        if (aa == msg.sender) {
            _;
        } else {
            ValidationError(msg.sender, this, aa, block.number);
            revert();
        }
    }

    function validate() internal returns(bool result) {
        if (CM != 0x0) {
            address am = ContractProvider(CM).contracts("actionmanager");
            if (am != 0x0) {
                address aa = ActionManagerProvider(am).activeAction();
                result = aa == msg.sender;
            }
        }
    }
}