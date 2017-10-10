pragma solidity 0.4.17;


interface ContractProvider {
    function contracts(bytes32 name) public returns(address);
}
