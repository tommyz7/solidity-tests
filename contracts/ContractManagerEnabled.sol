pragma solidity 0.4.17;


import './Interfaces/ContractProvider.sol';


contract ContractManagerEnabled {
    address public CM;

    function setCMAddress(address addr) public returns(bool) {
        if (addr != 0x0 && (CM == 0x0 || msg.sender == CM)) {
            CM = addr;
            return true;
        } else {
            return false;
        }
    }
}