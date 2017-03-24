pragma solidity ^0.4.0;

contract LeaseContract {
	address public owner;
	address public leasee;
	LeaseCoin leaseAmt;
	uint leaseStart;
	uint leaseEnd;
	bool ended;
	
	function LeaseContract(address _theLeasee,uint _theLeaseEnd,LeaseCoin _leaseAmt) {
		owner = msg.sender;
		leasee = _theLeasee;
		leaseAmt = _leaseAmt;
		leaseStart = now;
		leaseEnd = _theLeaseEnd;
	}

	event LeaseEnded(address leasee, LeaseCoin leaseAmt, uint leaseEnd);

	///function that validates if the lease is still valid and if so deduct balance accordingly
	// if lease is invalid throw error. If balance is empty, trigger leaseEnded event
	function validateLease() {
		if(now > (leaseStart + leaseEnd)) {
			throw;
		}
		if(ended) {
			throw;
		}
		if(now == (leaseStart + leaseEnd)) {
			LeaseEnded(msg.sender,balance,leaseEnd);
		}
		
		leaseAmt.deductFee(msg.sender);		

		if(leaseAmt.queryBalance() == 0) {
			ended = true;
			LeaseEnded(msg.sender,leaseAmt,leaseEnd);
		}
	}

	///function to add balance to a leaseContract
	function addBalance() payable {
		if (ended) {
			throw;
		}
		if(now > (leaseStart + leaseEnd)) {
			throw;
		}
		if(leasee != msg.sender) {
			throw;
		}
		leaseAmt.send(msg.sender,msg.value);
	}
}
