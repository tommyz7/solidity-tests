pragma solidity ^0.4.15;


contract ContractManagerEnabled {
    address public CM;

    function setCMAddress(address addr) public returns(bool) {
        if (CM == 0x0 || msg.sender == CM) {
            CM = addr;
            return true;
        } else {
            return false;
        }
    }
}