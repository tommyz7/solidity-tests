pragma solidity 0.4.17;


interface PermValidator {
    function validate(address caller, address activeAction) public returns(bool);
}
