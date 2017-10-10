var ContractManager = artifacts.require("./ContractManager.sol");
var ActionManager = artifacts.require("./ActionManager.sol");
var ActionDB = artifacts.require("./ActionDB.sol");
var PermissionDB = artifacts.require("./PermissionDB.sol");


module.exports = function(deployer, network, accounts) {
    deployer.deploy(ContractManager);
    deployer.deploy(ActionManager);
    deployer.deploy(ActionDB);
    deployer.deploy(PermissionDB);
};
