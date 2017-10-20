const Web3 = require('web3');
const TruffleConfig = require('../truffle');

var Migrations = artifacts.require("./Migrations.sol");

module.exports = function(deployer) {
    // in case unlocking account is required
    // const config = TruffleConfig.networks["development"];
    // const web3instance = new Web3('http://' + config.host + ':' + config.port);
    // console.log('>> Unlocking account ' + config.from);
    // web3instance.eth.personal.unlockAccount(config.from, "", 36000).then(function(result){
    //     console.log(result);
    //     console.log('>> Deploying migration');
    // });
    deployer.deploy(Migrations);
};
