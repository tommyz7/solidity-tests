pragma solidity ^0.4.15;


import 'zeppelin-solidity/contracts/lifecycle/Destructible.sol';
import './DoublyLinkedListOfContracts.sol';
import './ContractManagerEnabled.sol';


contract ContractManager is DoublyLinkedListOfContracts, Destructible {

    // when adding the contract
    event AddContract(bytes32 indexed name, address indexed addr, uint16 indexed code);
    // when removing the contract
    event RemoveContract(bytes32 indexed name, address indexed addr, uint16 indexed code);

    /**
     * @notice adds contract to contract manager list.
     * @param name contract's name by which contract will be pulled by other contracts
     * @param addr contract's address
     * @return success boolean value to indicate success or failure 
     */
    function addContract(bytes32 name, address addr) public onlyOwner returns(bool success) {
        // set contract manager so added contract can access contract's DB
        if (!ContractManagerEnabled(addr).setCMAddress(address(this))) {
            AddContract(name, addr, 403);
            return false;
        }
        success = _addElement(name, addr);
        if (success) {
            AddContract(name ,addr, 201);
        } else {
            // contract with that name is arleady added
            AddContract(name, addr, 409);
        }
    }

    /**
     * @notice Removes contract from contract manager's list 
     * @param name contract's name to remove
     * @return success boolean value to indicate success or failure 
     */
    function removeContract(bytes32 name) public onlyOwner returns(bool success) {
        address removedAddr;
        (success, removedAddr) = _removeElement(name);
        if (success) {
            RemoveContract(name, removedAddr, 201);
        } else {
            RemoveContract(name, removedAddr, 404);
        }
    }
}