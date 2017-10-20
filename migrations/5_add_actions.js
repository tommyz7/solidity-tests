var ActionDB = artifacts.require("./ActionDB.sol");
var ActionManager = artifacts.require("./ActionManager.sol");
var ActionSetActionPermission = artifacts.require("./ActionSetActionPermission.sol");
var ActionSetUserPermission = artifacts.require("./ActionSetUserPermission.sol");
var ActionAddAction = artifacts.require("./ActionAddAction.sol");

var AM;
var actiondb;
var addactionaddr;
var addAction;

// An async function
const setVaraibles = async function setVaraibles() {
    AM = await ActionManager.deployed();
    actiondb = await ActionDB.deployed();
    addactionaddr = await actiondb.actions("addaction");
    addAction = await web3.eth.contract(ActionAddAction._json.abi).at(addactionaddr);
};

const deployActionSetActionPermission = async function deployActionSetActionPermission() {
    let newAction = await ActionSetActionPermission.deployed();
    let callData = await addAction.execute.getData("setactionpermission", newAction.address);
    let result = await AM.execute("addaction", callData);
}

// TODO: clean this up and when truffle support async function in migrations, use it
module.exports = function(deployer, network, accounts) {
    deployer.then(function(){
        ActionDB.deployed().then(function(actiondb){
            return actiondb.actions("addaction");
        }).then(function(addactionaddr){
            return web3.eth.contract(ActionAddAction._json.abi).at(addactionaddr);
        }).then(function(addAction){
            return ActionSetActionPermission.deployed().then(function(instance){
                console.log(instance.address);
                return instance.address;
            }).then(function(addr){
                console.log(addr);
                return addAction.execute.getData("setactionpermission", addr);
            });
        }).then(function(callData){
            return ActionManager.deployed().then(function(AM){
                return AM.execute.call("addaction", callData);
            });
        }).then(function(result){
            console.log(result);
        });
    });
};

// module.exports = async function(deployer, network, accounts) {
    // let AM = await ActionManager.deployed();
    // let actiondb = await ActionDB.deployed();
    // let addactionaddr = await actiondb.actions("addaction");
    // let addAction = await web3.eth.contract(ActionAddAction._json.abi).at(addactionaddr);

//     // ActionSetActionPermission
    // let newAction = await ActionSetActionPermission.deployed();
    // let callData = await addAction.execute.getData("setactionpermission", newAction.address);
    // let result = await AM.execute("addaction", callData);

//     // ActionSetUserPermission
//     // newAction = await ActionSetUserPermission.deployed();
//     // callData = await addAction.execute.getData("setuserpermission", newAction.address);
//     // result = await AM.execute("addaction", callData);
// };
