pragma solidity 0.4.17;


import 'truffle/Assert.sol';
import '../contracts/ContractManagerEnabled.sol';
import '../contracts/ContractManager.sol';


contract TestContractManagerEnabled {
    ContractManagerEnabled CME = new ContractManagerEnabled();
    ContractManager CM = new ContractManager();

    function testSetCMAddress() public {
        bool result = CME.setCMAddress(CM);
        Assert.equal(result, true, "Contract manager should be set.");
    }

    function testSetZeroAddress() public {
        bool result = CME.setCMAddress(0x0);
        Assert.equal(result, false, "Zero address should not be added.");
    }

    function testDoubleSetCMAddress() public {
        bool result = CME.setCMAddress(CM);
        Assert.equal(result, false, "Contract manager is set already. It should fail.");
    }

    function testChangeCMbyCurrentContractManager() public {
        ContractManagerEnabled CMEn = new ContractManagerEnabled();
        bool result = CMEn.setCMAddress(this);
        Assert.equal(result, true, "Contract manager should be set.");

        result = CMEn.setCMAddress(CM);
        Assert.equal(result, true, "Contract manager should be set. Function called by current CM.");

        result = CMEn.setCMAddress(this);
        Assert.equal(result, false, "Contract manager should not be set. Function not called by current CM.");
    }
}