var ConvertLib = artifacts.require("./ConvertLib.sol");
var Test = artifacts.require("./Test.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, Test);
  deployer.deploy(Test);
};
