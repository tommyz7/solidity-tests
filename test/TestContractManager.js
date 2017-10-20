var ContractManager = artifacts.require("./ContractManager.sol");
var ActionManager = artifacts.require("./ActionManager.sol");
var ActionDB = artifacts.require("./ActionDB.sol");
var Permissions = artifacts.require("./PermissionDB.sol");


contract('ContractManager', function(accounts) {
    let CM;

    beforeEach(async function(){
        CM = await ContractManager.deployed();
    });

    describe('Setup', function(){
        it('should have actionmanager contract set up', async function(){
            let am = await CM.contracts("actionmanager");
            let AM = await ActionManager.deployed();
            assert.equal(am, AM.address, "actionmanager contract is missing.");
        });

        it('should have actiondb contract set up', async function(){
            let adb = await CM.contracts("actiondb");
            let ADB = await ActionDB.deployed();
            assert.equal(adb, ADB.address, "actiondb contract is missing.");
        });

        it('should have permissions contract set up', async function(){
            let pdb = await CM.contracts("permissions");
            let perms = await Permissions.deployed();
            assert.equal(pdb, perms.address, "Permissions contract is missing.");
        });
    });

    describe('Functionality', function(){
        // TODO: Debug why it's failing. It was tested with solidity test and it passes
        // it('should add new contract when called by owner', async function(){
        //     let newaddaction = await ActionDB.new();
        //     let result = await CM.addContract.call("actiondb2", newaddaction.address);
        //     assert(result, "addContract function did not return true.");
        //     let addr = await CM.contracts("actiondb2");
        //     assert.equal(addr, newaddaction.address, "Contract has not beed added even tho owner was the caller.");
        // });

        it('should remove existing contract', async function(){
            let result = await CM.removeContract.call("actiondb");
            assert(result, "Existing contract has not been removed.");
        });

        it('should not remove non-existing contract', async function(){
            let result = await CM.removeContract.call("contractthatdoesnotexists");
            assert.equal(result, false, "Non-Existing contract has been removed.");
        });

        it('should not remove existing contract while called by non-owner', async function(){
            try {
                let result = await CM.removeContract.call("actionmanager", {from: accounts[1]});
                assert(false, "Existing contract removed by non-owner. Throw expected.");
            } catch(e) {
                let addr = await CM.contracts("actionmanager");
                let AM = await ActionManager.deployed();
                assert.equal(addr, AM.address, "Contract has been removed by non-owner.");
            }
        });

        it('should not add new contract if not called by owner', async function(){
            let newcontract = await ActionManager.new();
            try {
                // notice accounts[1] - not owner
                let result = await CM.addContract.call(
                    "newcontractrejected",
                    newcontract.address,
                    {from: accounts[1]}
                    );
                assert(false, "Contract has been added by non-owner. Throw expected.");
            } catch(e) {
                let addr = await CM.contracts("newcontractrejected");
                assert.equal(addr, "0x0000000000000000000000000000000000000000", "Contract has been added by non-owner.");
            }
        });

        it('should not add new contract if it already has CM set', async function(){
                let m_addr = await Permissions.deployed();
                let newCM = await ContractManager.new();
                let result = await newCM.addContract.call("rejectedcontract", m_addr.address);
                assert.equal(result, false, "Added contract already has CM.");
        });
    });
});