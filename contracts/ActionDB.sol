pragma solidity 0.4.17;


import './DoublyLinkedListOfContracts.sol';
import './ActionManagerEnabled.sol';
import './ContractManagerEnabled.sol';
import './Actions/ActionAddAction.sol';


contract ActionDB is DoublyLinkedListOfContracts, Validee {

    event ActionAdded(bytes32 indexed actionName, address actionAddr, uint256 blockNum, bool success);
    event ActionRemoved(bytes32 indexed actionName, address actionAddr, uint256 blockNum, bool success);

    function setCMAddress(address addr) public returns(bool) {
        if (!super.setCMAddress(addr)) {
            return false;
        }

        // add addAction during setup to avoid egg and chicken problem
        ActionAddAction addAction = new ActionAddAction();
        return _addElement("addaction", addAction);
    }

    /**
     * @dev syntax sugar, does the same as contracts getter inherited from
     *      DoublyLinkedListOfContracts
     * @param name name of action
     * @return address address of action
     */
    function actions(bytes32 name) public view returns(address) {
        return elements[name].data;
    }

    /**
     * @dev don't remove it or there will be consequences :)
     */
    function addAction(bytes32 name, address addr)
            public
            validateActiveAction
            returns(bool) {
        if (!ContractManagerEnabled(addr).setCMAddress(CM)) {
            ActionAdded(name, addr, block.number, false);
            return false;
        }
        bool result = _addElement(name, addr);
        ActionAdded(name, addr, block.number, result);
        return result;
    }

    function removeAction(bytes32 name)
            public
            validateActiveAction
            returns(bool) {
        if (actions(name) == 0x0) {
            ActionRemoved(name, 0x0, block.number, false);
            return false;
        }

        var (result, addr) = _removeElement(name);
        ActionRemoved(name, addr, block.number, result);
        return result;
    }
}