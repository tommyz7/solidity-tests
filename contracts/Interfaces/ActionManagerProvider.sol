pragma solidity 0.4.17;


interface ActionManagerProvider {
    function activeAction() public returns(address);
    function locked() public returns(bool);
    function permToUnlock() public returns(uint8);
}
