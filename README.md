# 🎶 Blockchain Build-along 🎶

### You're on the build-along branch!

This is a special tutorial for learning Solidity basics. If you are not part of a workshop, you might want to return to the [master](https://github.com/ann-kilzer/blockchain-stamp-rally) branch.

## Prerequisites

- [Chrome](https://www.google.com/chrome/) or [Firefox](https://www.mozilla.org/en-US/firefox/new/) Web Browser
- Install the web3 plugin [MetaMask](https://metamask.io/)
  - Create a New Wallet and Seed Phrase
  - Follow the instructions to set up a wallet
- Get some test Ethereum
  - Open up MetaMask
  - Make sure you have the "Rinkeby" network selected. This is a test network that lets people experiment with using Ethereum for free. It is different than "Mainnet" or real Ethereum, which has a [fluctuating price.](https://ethereumprice.org/)
  - Copy your account address from MetaMask
  - Visit this [Rinkeby Test ETH faucet](https://faucet.rinkeby.io/) and follow the directions to get test Ethereum.

## Open the Remix IDE
- Open [remix](remix.ethereum.org) in a browser tab, and click "Solidity" under environments.
- Click the "File Explorer" icon (first from top), then click the + to open a new file. Name it StampRally.sol.
- Copy the code from [StampRally.sol](https://github.com/ann-kilzer/blockchain-stamp-rally/blob/build-along/contracts/StampRally.sol) into a the Remix browser.
- You're now ready to write code and interact with the smart contract.
- Fill in the TODOs in the code.

## Checking your work

- Click the "Compile" tab (second from top) to build your code
- Click the "Deploy and Run Transactions" tab (third from top)

### Deploying a contract

1. Under Environments, click "Injected Web3"
2. Select which account you wish to deploy from. This will become the contract owner, and it will be the only account able to manage the game (unless you transfer ownership).
3. Choose the number of stamps available in your rally, as well as the rally name.
3. Click Deploy. You will see a popup asking for you to sign and submit the transaction. Click to accept.
4. In the bottom drawer you will see a link to view the transaction on etherscan.io. Click this, and wait until you see TxReceipt Status:Success. This means your contract has been deployed and mined into a block.
5. Look for the contract address `[Contract 0xabcd... Created]` and click on it to view the contract page.
6. Copy the contract address to a safe place. You'll need it to set up stamps, and to give to your players

### Running a command

1. Make sure you are on the "Deploy and Run Transactions" tab
2. Click on a deployed contract
3. Click on a method and enter parameters
4. Click call for view (read-only) methods, or transact for write methods (which require signing)

### Interacting with the Web3 frontend

- Visit [this page](https://ann-kilzer.github.io/blockchain-stamp-rally/?)
- Make sure MetaMask is set to Rinkeby.
- Click on the gear and enter the following address: [0x46035fA4922F006EE4eCde4BD70090811cB19a23](https://rinkeby.etherscan.io/address/0x46035fa4922f006ee4ecde4bd70090811cb19a23).
- Click LINK
- The first password is "octopus". Try entering it, signing the MetaMask transaction. Wait a few moments for the image to appear!
- You can also try deploying your own contract instance to Rinkeby. See steps below for setting up your own Stamp Rally.

### Keep learning

Thanks for participating in the build-along. This is just a taste of Solidity code. If you'd like to learn more about Ethereum and Blockchain, I recommend the following resources:

- ⭐ [Crypto Zombies](cryptozombies.io)
- [Truffle Suite](https://www.trufflesuite.com/)
- [Bitcoin and Cryptocurrency Technologies online course](https://www.coursera.org/learn/cryptocurrency)


[ End of tutorial 🙇‍♀️ ]

# Blockchain Stamp Rally

[Stamp Rallies](https://www.tokyoweekender.com/2009/08/stamp-rallies/) are a scavenger hunt type game popular in Japan, usually centered around railway travel or walking. A card contains a number of blank spaces with destinations. At each destination, is a table with a stamp and ink pad to mark the sheet. Players may redeem a fully stamped sheet for a prize, or an entry into a drawing.

I created this game to make a virtual stamp rally for my coworkers. Rather than traveling to a location, the stamp images are only revealed after entering a password, revealed upon completing a challenge.

Passphrases could be code words, solutions to puzzles, or revealed via locations in virtual worlds. Using Blockchain as the data store keeps a decentralized source of truth.

## How to play

- web3 plugin [Metamask](https://metamask.io/)
- An address of the deployed instance of the stamp rally contract
  - A Sample Contract is at [0x46035fA4922F006EE4eCde4BD70090811cB19a23](https://rinkeby.etherscan.io/address/0x46035fa4922f006ee4ecde4bd70090811cb19a23) on Rinkeby. The first password is "octopus".
  - See below for [how game managers can set up a stamp rally](#how-to-set-up-a-stamp-rally-for-game-managers)
- Some test Ether
  - [Rinkeby Test Eth](https://faucet.rinkeby.io/)

Visit [this page](https://ann-kilzer.github.io/blockchain-stamp-rally/?) to interact with a deployed version of the frontend.  Use the gear icon to link the address of the Stamp Rally Contract.

Make sure to use the same Ethereum Address to play the game every time, if you want the images to show up on the same game card.

## How to run from source:

Prerequisites:

 - [yarn](https://yarnpkg.com/en/)

Clone this git repo and navigate to the webui directory and install dependencies.

```
cd webui
yarn install
```

Now you can fire up the app with:
`yarn serve`

Navigate to http://localhost:8080 in your web3 enabled browser to start the game.

## How to set up a Stamp Rally (For game managers)

I recommend deploying on a test network such as Rinkeby. That way you get a public Blockchain without the high cost of real Ether. Make sure you have some [test Ethereum](https://faucet.rinkeby.io/) in order to deploy the contract.

### Contract Deployment

1. Navigate to https://remix.ethereum.org in a web3 enabled browser. Make sure your browser is connected to the correct network -- in this case, Rinkeby.
2. Click the plus icon to add a new file. Copy the contents of [StampRally.sol](https://github.com/ann-kilzer/blockchain-stamp-rally/blob/master/contracts/StampRally.sol) into the text area.
3. Select the 0.5.0 version of the compiler and wait for it to compile.
4. Click the **Run** tab.
5. Select which account you wish to deploy from. This will become the contract owner, and it will be the only account able to manage the game (unless you transfer ownership).
6. Choose the number of stamps available in your rally, as well as the rally name.
7. Click Deploy. You will see a popup asking for you to sign and submit the transaction. Click to accept.
8. In the bottom drawer you will see a link to view the transaction on etherscan.io. Click this, and wait until you see TxReceipt Status:Success. This means your contract has been deployed and mined into a block.
9. Look for the contract address `[Contract 0xabcd... Created]` and click on it to view the contract page.
10. Copy the contract address to a safe place. You'll need it to set up stamps, and to give to your players.

### Creating images
I recommend copying the BlankStamp.jpg image and adding your own drawings in the center, using photo editing software like Photoshop or the Gimp. Dimensions are 1000x1000px.

Here's an example:

<img src="https://github.com/ann-kilzer/blockchain-stamp-rally/blob/master/sample-images/RubberDuck.jpg?raw=true" width="300" height="300" alt-text="Duck Stamp Example">

### Saving Images

There are a number of options for where to save images for your own stamp rally.

1. Fork the repo and add in your own images.
 - Pros: Simple and free. Same origin, no [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) issues.
 - Cons: No element of surprise for players to discover stamps


2. Your own website:
 - Pros: Ability to hide stamps
 - Cons: CORS configuration is a challenge. Cost of hosting


3. Amazon S3
 - Pros: Ability to hide stamps
 - Cons: CORS configuration is a challenge. Cost of hosting. I recommend not leaking the image URLs, as Amazon discourages public buckets.

#### How to set up S3 for image hosting
1. Log into the [AWS S3 management console](https://s3.console.aws.amazon.com/s3/home).
2. Create a new bucket and give it a unique name.
3. Configure the public access settings for this bucket. Uncheck everything because Amazon's recommendations are pretty maddening.*
  - Block new public ACLS and uploading public objects -- Unchecked
  - Remove public access granted through ACLS -- Unchecked
  - Block new public bucket policies -- Unchecked
  - Block public and cross-account access if bucket has public policies -- Unchecked.

4. Click the permissions tab.
   In the bucket policy editor, add the following, replacing "myBucket" with the name of your bucket:
 ```
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::myBucket/*"
        }
    ]
}
```
5. Under the CORS configuration tab, add the following:
```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```
6. Upload your images to S3 using the upload button. You can put all your images in the same bucket. To keep stamps a surprise, give images names that aren't easy for players to guess.
7. Keep track of the Object URL for each stamp.


### Setting up stamps

1. Decide which images and prompts (hints or instructions) to correspond to each stamp index. Indexes start at 0 and go to N-1, for a game with N stamps.
2. Go back to https://remix.ethereum.org with the contract loaded. You should see your deployed contract in the lower right. Or you can add the saved address into the "At Address" field.
3. Make sure that your web3 enabled browser has the contract owner (the same address you deployed from) as the selected signer.
4. For each index, call the following two methods in order:
  - generateHash with the password, to create the hashed passphrase
  - setStamp using the index, the hash generated in the previous step, the url, and the prompt
5. Give the contract address out to your players and let the games begin!


\* Presumably these recommendations are to keep malicious actors from eating up your AWS budget by slamming your public S3 urls... so be cautious about where you share your image links, and please set up budget monitoring.
