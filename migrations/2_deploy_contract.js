const cyCb = artifacts.require("./cyCb.sol");

module.exports = function(deployer) {
  deployer.deploy(cyCb);
};