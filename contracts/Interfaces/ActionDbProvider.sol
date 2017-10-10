pragma solidity 0.4.17;


interface ActionDbProvider {
    function actions(bytes32 name) public returns(address);
    function addAction(bytes32 name, address addr) public returns(bool);
}
