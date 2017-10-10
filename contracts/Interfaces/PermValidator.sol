pragma solidity 0.4.17;


interface PermValidator {
    function validate(address caller, address activeAction) public returns(bool);
    function setPermission(address userAddr, uint8 perm) public returns(bool);
}
