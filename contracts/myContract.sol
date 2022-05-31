// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract testContract {
    
    mapping(uint256 => address) private subscribers;
    uint256 private subscriberCount;

    struct articleInfo{
        uint256 articleNo;
        string atricleTitle;
        string articleCID;
        uint256 articleTimeStamp;
    }

    mapping(uint256 => articleInfo) private articles;
    uint256 private articleCount;

    address payable private author;

    uint256 public subscriptionFee;
    string public channelName;


    modifier onlyOwner {
        require(msg.sender == author, "Only author can call this method!");
        _;
    }

    event articlePublished(string indexed channelName, string articleTitle, string articleCID, uint256 articleTimeStamp);

    constructor(uint _fee, string memory _channelName){
        author = payable(msg.sender);
        subscriptionFee = _fee * 1e9;
        channelName = _channelName;
        subscriberCount = 0;
        articleCount = 0;
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

    function publishArticle(string memory _articleTitle, string memory _articleCID) payable public onlyOwner {
        articles[articleCount] =  articleInfo(articleCount, _articleTitle, _articleCID, block.timestamp);
        articleCount++;

        emit articlePublished(channelName, _articleTitle, _articleCID, block.timestamp);
    }

    fallback() payable external{
        require( msg.value ==  subscriptionFee , "Payment should be the subscription fee only"    );
    }

    receive() payable external{
        require( msg.value ==  subscriptionFee , "Payment should be the subscription fee only"    );
    }

}