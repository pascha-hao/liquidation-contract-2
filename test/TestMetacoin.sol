pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Test.sol";

contract TestTest {

  function testInitialBalanceUsingDeployedContract() public {
    Test tester = Test(DeployedAddresses.Test());

    uint expected = 10000;

    Assert.equal(tester.getBalance(tx.origin), expected, "Owner should have 10000 Test initially");
  }

  function testInitialBalanceWithNewTest() public {
    Test tester = new Test();

    uint expected = 10000;

    Assert.equal(tester.getBalance(tx.origin), expected, "Owner should have 10000 Test initially");
  }

}
