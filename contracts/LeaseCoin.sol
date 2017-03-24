pragma solidity ^0.4.0;

contract LeaseCoin {
	address minter;
	mapping (address=>uint) balances;
	
	function LeaseCoin() {
		minter = msg.sender;
	}
	
	function mint(address owner,uint amount) {
		if(msg.sendr != owner) {
			return;
		}
		balances[owner] += amount;
	}
	function send(address receiver,uint amount) {
		if(balances[msg.sender] < amount) {
			return;
		} 
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
	}
	function deductFee(address receiver) {
		if(balances[receiver] > 0) {
			return;
		}
		balances[msg.sender] += 1;
		balances[receiver] -= 1;
	}
	function queryBalance(address client) constant returns (uint balance) {
		return balances[client];
	}
}
