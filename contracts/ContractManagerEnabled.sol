pragma solidity 0.4.17;


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