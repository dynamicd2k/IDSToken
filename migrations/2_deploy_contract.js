const IDSNFTMP = artifacts.require("./IDSNFTMP.sol");

module.exports = function(deployer) {
  deployer.deploy(IDSNFTMP);
};