pragma solidity 0.4.17;


import 'truffle/Assert.sol';
import '../contracts/ContractManager.sol';
import '../contracts/ContractManagerEnabled.sol';


contract TestContractManager {

    ContractManagerEnabled CME1 = new ContractManagerEnabled();
    ContractManager CM = new ContractManager();
    bytes32 constant contract1 = "contract1";

    function testOwner() public {
        Assert.equal(CM.owner(), address(this), "Test contract should be the owner.");
    }

    function testAddContract() public {
        bool result = CM.addContract(contract1, CME1);
        Assert.equal(result, true, "Contract should be added.");
    }

    function testAddZeroContract() public {
        bool result = CM.addContract("contractzero", 0x0);
        Assert.equal(result, false, "Zero address should not be added.");
    }

    function testAddContractWithAlreadyUsedName() public {
        ContractManagerEnabled CME2 = new ContractManagerEnabled();
        bool result = CM.addContract(contract1, CME2);
        Assert.equal(result, false, "Contract should not be added. Name already used.");
    }

    function testAddContractWithCMAlreadySet() public {
        ContractManager CM2 = new ContractManager();
        bool result = CM2.addContract("contract2", CME1);
        Assert.equal(result, false, "Contract should not be added. It already has contract manager set.");
    }

    function testGetAddressOfAddedContract() public {
        address addr = CM.contracts(contract1);
        Assert.equal(addr, address(CME1), "Contract address should be equal to previously added contract.");
    }

    function testGetAddresOfNotAddedContract() public {
        address addr = CM.contracts("contractThatDoesNotExists");
        Assert.equal(addr, 0x0, "Returned address should be 0x0.");
    }

    function testRemoveContractWithNonExistingContract() public {
        bool result = CM.removeContract("contractThatDoesNotExists");
        Assert.equal(result, false, "Result should be false. Contract does not exists.");
    }

    function testRemoveContract() public {
        bool result = CM.removeContract(contract1);
        Assert.equal(result, true, "Result of removeContract should be true.");
    }
}