// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

contract MovieTicketPurchase {

    address public owner;
    mapping(address => uint) public ticketBalances;

    constructor() {
        owner = msg.sender;
        ticketBalances[address(this)] = 200;
    }

    function getTicketBalances() public view returns(uint) {
        return ticketBalances[address(this)];
    }

    function reStock(uint amount) public {
        require(msg.sender == owner, "Only owner can call this fucntion.");
        ticketBalances[address(this)] += amount;
    }

    function purchaseTicket(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You have to pay the required purchasing fee.");
        require(ticketBalances[address(this)] >= amount, "Ticket available cannot fulfill your request");
        ticketBalances[address(this)] -= amount;
        ticketBalances[msg.sender] += amount;
    }
}
