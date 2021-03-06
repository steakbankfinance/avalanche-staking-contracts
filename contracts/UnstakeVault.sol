pragma solidity 0.6.12;

import "./interface/IVault.sol";
import "openzeppelin-solidity/contracts/utils/ReentrancyGuard.sol";

contract UnstakeVault is IVault, ReentrancyGuard {
    address payable public steakBank;

    event Deposit(address from, uint256 amount);
    event Withdraw(address recipient, uint256 amount);

    constructor(address payable steakBankAddr) public {
        steakBank = steakBankAddr;
    }

    /* solium-disable-next-line */
    receive() external payable{
        emit Deposit(msg.sender, msg.value);
    }

    modifier onlySteakBank() {
        require(msg.sender == steakBank, "only steakBank is allowed");
        _;
    }

    function claimAVAX(uint256 amount, address payable recipient) nonReentrant onlySteakBank override external returns(uint256){
        if (address(this).balance < amount) {
            amount = address(this).balance;
        }
        recipient.transfer(amount);
        emit Withdraw(recipient, amount);
        return amount;
    }
}