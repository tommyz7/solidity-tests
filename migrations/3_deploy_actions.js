var ActionSetActionPermission = artifacts.require("./ActionSetActionPermission.sol");
var ActionSetUserPermission = artifacts.require("./ActionSetUserPermission.sol");


module.exports = function(deployer, network, accounts) {
    deployer.deploy(ActionSetActionPermission);
    deployer.deploy(ActionSetUserPermission);
};
