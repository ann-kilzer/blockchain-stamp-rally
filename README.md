# Blockchain Stamp Rally

[Stamp Rallies](https://www.tokyoweekender.com/2009/08/stamp-rallies/) are a scavenger hunt type game popular in Japan, usually centered around railway travel or walking. A card contains a number of blank spaces with destinations. At each destination, is a table with a stamp and ink pad to mark the sheet. Players may redeem a fully stamped sheet for a prize, or an entry into a drawing.

I created this game to make a virtual stamp rally for my coworkers. Rather than traveling to a location, the stamp images are only revealed after entering a password, revealed upon completing a challenge.

Passphrases could be code words, solutions to puzzles, or revealed via locations in virtual worlds. Using Blockchain as the data store keeps a decentralized source of truth.


## How to play

Prerequisites:
- [yarn](https://yarnpkg.com/en/) v1.12.3
- web3 enabled browser such as [Mist](https://github.com/ethereum/mist/releases) or [Metamask](https://metamask.io/)
- An address of the deployed instance of the stamp rally contract (See below for [how game managers can set up a stamp rally](#how-to-set-up-a-stamp-rally-for-game-managers))
- Some test Ether
  - [Rinkeby Test Eth](https://faucet.rinkeby.io/)

Clone this git repo and navigate to the webui directory and install dependencies.

`cd webui`
`yarn install`

Now you can fire up the app with:
`yarn start`

Navigate to http://localhost:3333 in your web3 enabled browser to start the game. Use the gear icon to link the address of the Stamp Rally Contract.

Make sure to use the same Ethereum Address to play the game every time, if you want the images to show up on the same game card.

## How to set up a Stamp Rally (For game managers)

I recommend deploying on a test network such as Rinkeby. That way you get a public Blockchain without the high cost of real Ether. Make sure you have some [test Ethereum](https://faucet.rinkeby.io/) in order to deploy the contract.

### Contract Deployment

1. Navigate to https://remix.ethereum.org in a web3 enabled browser. Make sure your browser is connected to the correct network -- in this case, Rinkeby.
- Click the plus icon to add a new file. Copy the contents of [StampRally.sol](https://github.com/ann-kilzer/blockchain-stamp-rally/blob/master/contracts/StampRally.sol) into the text area.
- Select the 0.5.0 version of the compiler and wait for it to compile.
- Click the **Run** tab.
- Select which account you wish to deploy from. This will become the contract owner, and it will be the only account able to manage the game (unless you transfer ownership).
- Choose the number of stamps available in your rally, as well as the rally name.
- Click Deploy. You will see a popup asking for you to sign and submit the transaction. Click to accept.
- In the bottom drawer you will see a link to view the transaction on etherscan.io. Click this, and wait until you see TxReceipt Status:Success. This means your contract has been deployed and mined into a block.
- Look for the contract address `[Contract 0xabcd... Created]` and click on it to view the contract page.
- Copy the contract address to a safe place. You'll need it to set up stamps, and to give to your players.

### Creating images
I recommend copying the BlankStamp.jpg image and adding your own drawings in the center, using photo editing software like Photoshop or the Gimp. Dimensions are 1000x1000px.

Here's an example:

![duck stamp](https://github.com/ann-kilzer/blockchain-stamp-rally/blob/master/sample-images/RubberDuck.jpg?raw=true width="100" height="100")

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

*TODO #6* Finish S3 tutorial and upload sample CORS configuration.

### Setting up stamps

*TODO*
