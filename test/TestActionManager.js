var ActionManager = artifacts.require("./ActionManager.sol");
var ActionSetActionPermission = artifacts.require("./ActionSetActionPermission.sol");
var ActionAddAction = artifacts.require("./ActionAddAction.sol");
var ActionDB = artifacts.require("./ActionDB.sol");


contract('ActionManager', function(accounts){
    let AM;
    let actionDB;

    beforeEach(async function(){
        AM = await ActionManager.deployed();
        actionDB = await ActionDB.deployed();
    });

    describe('ActionDB', function(){
        it('should add setActionPermission action to database', async function(){
            let addActionAddr = await actionDB.actions("addaction");
            let addActionContract = web3.eth.contract(ActionAddAction._json.abi).at(addActionAddr);

            // var events = addAction.allEvents([], function(error, log){if (!error) console.log(log); else console.log(error);});

            let setActionPermission = await ActionSetActionPermission.deployed();
            let callData = addActionContract.execute.getData("TESTsetactionpermission", setActionPermission.address);
            let result = await AM.execute.call("addaction", callData);
            assert.equal(result, true, "setActionPermission action has not been added.");
            let addedAction = await actionDB.actions("setactionpermission");
            assert.equal(addedAction, setActionPermission.address, "Action has not been added.");
        });
        // TODO:
        // test calling stright to actions

        // it('should add serUserPermission action to database', async function(){});

        // it('should not add setActionPermission action to database', async function(){});
        // it('should not add serUserPermission action to database', async function(){});

        // it('should remove setActionPermission from database', async function(){});
        // it('should remove serUserPermission from database', async function(){});

        // it('should not remove setActionPermission from database', async function(){});
        // it('should not remove serUserPermission from database', async function(){});
    });

    describe('PermissionDB', function(){
        // it('should add setActionPermission action to database', async function(){});
        // it('should add serUserPermission action to database', async function(){});

        // it('should set permission level to 255 for account[0]', async function(){});

        // it('should set permissions for addAction to 255', async function(){});
        // it('should set permissions for setActionPermission to 255', async function(){});
        // it('should set permissions for setUserPermission to 255', async function(){});

        // it('should disallow to add new action for account[1]', async function(){});
        // it('should disallow to setActionPermission for account[1]', async function(){});
        // it('should disallow to setUserPermission for account[1]', async function(){});

        // it('should set permission to 255 for account[1]', async function(){});

        // it('should allow to add new action for account[1]', async function(){});
        // it('should allow to setActionPermission for account[1]', async function(){});
        // it('should allow to setUserPermission for account[1]', async function(){});
    });
});