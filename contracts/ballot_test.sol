// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract myContract {

    string stringValue;

    constructor() public {
        stringValue = "value";
    }

    function get() public view returns(string memory) {
        return stringValue;
    }

    function set(string memory _value) public {
        stringValue = _value;
    }
}