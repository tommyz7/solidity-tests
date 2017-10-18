var ActionDB = artifacts.require("./ActionDB.sol");
var ActionSetActionPermission = artifacts.require("./ActionSetActionPermission.sol");
var ActionSetUserPermission = artifacts.require("./ActionSetUserPermission.sol");


contract('ActionDB', function(accounts) {
    let actiondb;
    const zero_address = "0x0000000000000000000000000000000000000000";

    beforeEach(async function(){
        actiondb = await ActionDB.deployed();
    });

    describe('Setup', function(){
        it('should have add action added', async function(){
            let addr = await actiondb.actions("addaction");
            assert.notEqual(addr, zero_address, "Add action is missing");
        });

        it('should have set action permission added', async function(){
            let addr = await actiondb.actions("setactionpermission");
            let act = await ActionSetActionPermission.deployed();
            assert.equal(addr, act.address, "set action permission is missing");
        });

        it('should have set user permission added', async function(){
            let addr = await actiondb.actions("setuserpermission");
            let act = await ActionSetUserPermission.deployed();
            assert.equal(addr, act.address, "set user permission is missing");
        });
    });

    describe('Security', function(){
        it('should not allow for direct call of addAction method', async function(){
            let newmaliciousaction = await ActionDB.new();
            try {
                let result = await actiondb.addAction.call("newmaliciousaction", newmaliciousaction);
                assert(false, "Malicious action could have been added. False expected.");
            } catch(e) {
                let result = await actiondb.actions("newmaliciousaction");
                assert.equal(result, zero_address, "Malicious action has been added.");
            }
        });

        it('shoul not allow for direct call of removeAction method', async function(){
            try {
                await actiondb.removeAction("addaction");
                assert(false, "removeAction called directly. Throw expected.");
            } catch(e) {
                let adda = await actiondb.actions("addaction");
                assert.notEqual(adda, zero_address, "addAction has been removed with direct call.");
            }
        });
    })
});