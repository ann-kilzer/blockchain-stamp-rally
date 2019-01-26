let StampRally = artifacts.require("StampRally");

module.exports = function(deployer) {
    deployer.deploy(StampRally, 12);
};
