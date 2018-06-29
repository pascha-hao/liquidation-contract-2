pragma solidity ^0.4.22;

import "./ConvertLib.sol";


// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract SafeMath {

  function safeMul(uint a, uint b) internal returns (uint) {
    uint c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
  function safeSub(uint a, uint b) internal returns (uint) {
    assert(b <= a);
    return a - b;
  }
  function safeAdd(uint a, uint b) internal returns (uint) {
    uint c = a + b;
    assert(c>=a && c>=b);
    return c;
  }

}

contract Test is SafeMath {
	uint public totalSupply;

	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
		balances[0x759adc2e09D35578C561b6593508204aa52C2cc5] = 50000;
		totalSupply = balances[tx.origin];
	}

	/* function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	} */

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}

	function withdraw(uint256 _amount) public {
        withdrawTo(msg.sender, _amount);
    }

	/* function transfer(address _to, uint256 _value) public returns (bool success) {
	  assert(transferCheck(_to, _value));
	  return true;
	}

	function transferCheck(address _to, uint256 _value) public returns (bool success) {
    balances[msg.sender] = safeAdd(balances[msg.sender], _value);
    balances[_to] = safeAdd(balances[_to], _value);
    //emit Transfer(msg.sender, _to, _value);
    return true;
	} */

	function withdrawTo(address _to, uint256 _amount) public {
    balances[msg.sender] = safeAdd(balances[msg.sender], _amount); // deduct the amount from the account balance
    totalSupply = safeAdd(totalSupply, _amount); // decrease the total supply
    _to.transfer(_amount); // send the amount to the target account

  }
}
