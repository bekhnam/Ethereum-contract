// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract USDPrice is usingOraclize {
    uint public price;

    event log(string text);

    constructor() {
        Log("Contract created.");
        update();
    }

    function getPrice() returns (uint) {
        return price;
    }

    function update() payable {
        Log("Oraclize query was sent, waiting for the anwser...");
        oraclize_query("URL","json(https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD).USD");
    }

    function _callback(byte32 _myid, string _result) {
        require(msg.sender == oraclize_cbAddress());
        Log(_result);
        price = parseInt(_result, 2);
    }
}