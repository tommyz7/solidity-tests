var ContractManager = artifacts.require("./ContractManager.sol");
var ActionManager = artifacts.require("./ActionManager.sol");
var ActionDB = artifacts.require("./ActionDB.sol");
var Permissions = artifacts.require("./PermissionsDB.sol");


module.exports = function(deployer, network, accounts) {
    ContractManager.deployed().then(function(CM){
        CM.addContract("actionmanager", ActionManager.address);
        CM.addContract("actiondb", ActionDB.address);
        CM.addContract("permissions", Permissions.address);
    });
};
