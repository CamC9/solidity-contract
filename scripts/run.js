const { ethers } = require("hardhat");

async function main() {
    const [owner, randPerson] = await ethers.getSigners();
    const emojiContractFactory = await hre.ethers.getContractFactory("EmojiPortal");
    const emojiContract = await emojiContractFactory.deploy();
    await emojiContract.deployed();
    console.log("Contract deployed to: ", emojiContract.address);
    console.log("Contract deployed by: ", owner.address);

    let emojiCount = await emojiContract.getTotalEmojis();
    console.log(emojiCount.toNumber());

    let emojiTxn = await emojiContract.sendEmoji("1st message!");
    await emojiTxn.wait();

    emojiTxn = await emojiContract.connect(randPerson).sendEmoji("2nd message!");
    await emojiTxn.wait();

    let allEmojis = await emojiContract.getAllSentEmojis();
    console.log(allEmojis);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });