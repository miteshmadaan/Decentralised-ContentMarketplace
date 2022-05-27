// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract testContract {
    
    mapping(uint => address) private subscribers;
    uint private subscriberCount = 0;

    address payable private author;
    uint public subscriptionFee;
    string public channelName;

    modifier onlyOwner {
        require(msg.sender == author, "Only author can call this method!");
        _;
    }

    constructor(uint _fee, string memory _channelName){
        author = payable(msg.sender);
        subscriptionFee = _fee * 1e9;
        channelName = _channelName;
    }

    function addSubscriber() public payable{
        subscribers[subscriberCount] = msg.sender;
        subscriberCount++;
        payable(address(this)).transfer(msg.value);
    }

    function withdrawAmount() payable public onlyOwner{
        author.transfer(address(this).balance);
    }

    function printSubscribersList() public onlyOwner view returns(address[] memory){
        address[] memory ret = new address[](subscriberCount);
        for(uint i = 0; i < subscriberCount; i++){
            ret[i] = subscribers[i];
        }
        return ret;
    }

    fallback() payable external{
        require( msg.value ==  subscriptionFee , "Payment should be the subscription fee"    );
    }

    receive() payable external{
        require( msg.value ==  subscriptionFee , "Payment should be the subscription fee"    );
    }

}