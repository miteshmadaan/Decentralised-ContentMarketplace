// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract testContract {
    
    mapping(uint => subscriber) public subscribers;
    uint public subscriberCount = 0;

    struct subscriber {
        string name;
        address addr;
    }

    address payable public author;
    uint public subscriptionFee;

    event SubscriberPrint(string name, address addr);
    event Received(string name, address addr, uint amount);

    constructor(uint fee){
        author = payable(msg.sender);
        subscriptionFee = fee * 1e18;
    }

    function getContractBalance() public view returns (uint){
        return address(this).balance;
    }

    fallback() payable external{
        require( msg.value ==  subscriptionFee , "Payment should be the subscription fee"    );
    }

    receive() payable external{
        require( msg.value ==  subscriptionFee , "Payment should be the subscription fee"    );
        // emit Received(msg.sender, msg.value);
    }

    function getAuthorBalance() public view returns(uint){
        return author.balance;
    }

    function addSubscriber(string memory userName) public payable{
        subscribers[subscriberCount] = subscriber(userName,msg.sender);
        subscriberCount++;
        payable(address(this)).transfer(msg.value);
        emit Received(userName, msg.sender, msg.value);
    }
 
    function withdrawAmount() payable public{
        require(
            msg.sender == author, "Only author can call!"
        );
        payable(author).transfer(address(this).balance);
    }

    function printSubscribersList() public {
        subscriber memory ret;
        for(uint i = 0; i < subscriberCount; i++){
            ret = subscribers[i];
            emit SubscriberPrint(ret.name, ret.addr);
        }
    }

}