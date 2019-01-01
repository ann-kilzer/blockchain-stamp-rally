pragma solidity 0.5.0;


contract StampRally {
  string public prefix; // url prefix for the stamp images
  uint8 public numStamps;
  struct Stamp {
    bytes32 hashedPassphrase;

  }

  struct Rally {
    Stamp[] stamps;
    bool valid;
  }
  
  Rally[] public rallies;

  mapping (address => Rally) public playerToRally;

  constructor(uint8 _numStamps, string memory _prefix) public {
    prefix = _prefix;
    numStamps = _numStamps;
  }


  function initializeRally(address _player) internal {
    Rally storage rally = playerToRally[_player];
    rally.valid = true;
    rally.stamps = new Stamp[](numStamps);
  }
  
  function collectStamp(uint8 position, string memory passphrase) public {
    //Rally memory rally = playerToRally[msg.sender];
    //if (!rally.valid) {
    //  initializeRally(msg.sender);
    //}
    // todo
  }

  function getStamp(uint8 position) public view returns (string memory) {


  }
  
}
