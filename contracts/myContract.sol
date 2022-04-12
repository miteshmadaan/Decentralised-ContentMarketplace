// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract testContract {
    
    mapping(uint => subscriber) public subscribers;
    uint public subscriberCount = 0;
 
    struct subscriber {
        string name;
        address addr;
    }


    string public author;

    
    function addSubscriber(string memory userName) public {
        subscribers[subscriberCount] = subscriber(userName,msg.sender);
        subscriberCount++;
    }
 
    function getSubscriberCount() public view returns(uint256) {
        return subscriberCount;
    }

    function printSubscribersList() public view returns(subscriber[]memory){
        subscriber[] memory ret = new subscriber[](subscriberCount);
        for(uint i = 0; i < subscriberCount; i++){
            ret[i] = subscribers[i];
        }
        return ret;
    }

}