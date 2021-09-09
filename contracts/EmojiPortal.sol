// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract EmojiPortal {
    uint totalEmojis;

    event NewEmoji(address indexed from, uint timestamp, string message);

    struct Emoji {
        address sender;
        string message;
        uint timestamp;
    }

    Emoji[] emojis;

    constructor() {
        console.log("Constructed!");
    }

    function sendEmoji(string memory _message) public {
        totalEmojis += 1;
        console.log('%s emoji\'d everyone w/ message: "%s"', msg.sender, _message);

        // Where we store the emoji data in the array
        emojis.push(Emoji(msg.sender, _message, block.timestamp));

        emit NewEmoji(msg.sender, block.timestamp, _message);
    }

    function getAllSentEmojis() view public returns (Emoji[] memory) {
        return emojis;
    }

    function getTotalEmojis() view public returns (uint) {
        console.log("There are %d people that have been emoji'd", totalEmojis);
        return totalEmojis;
    }
}