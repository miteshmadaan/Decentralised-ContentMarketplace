// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract testContract {
    
    

    address[] public subscribers;

    address public author;

    
    function addSubscriber(address user) public {
        subscribers.push(user);
    }
 
    function getSubscriberCount() public view returns(uint256) {
        return subscribers.length;
    }

    function printSubscribersList() public view returns(address[] memory){
        return subscribers;
    }

}