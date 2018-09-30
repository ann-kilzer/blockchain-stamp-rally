pragma solidity 0.4.24;


contract StampRally {
  string public prefix; // url prefix for the stamp images
  uint8 public numStamps;
  struct Stamp {
    bytes32 private hashedPassphrase;

  }

  struct Rally {
    Stamp[] public stamps;
    bool public valid;
  }
  
  Rally[] public rallies;

  mapping (address => Rally) public playerToRally;

  constructor(uint8 _numStamps, string _prefix) {
    prefix = _prefix;
    numStamps = _numStamps;
  }


  function initializeRally(address _player) internal {
    Rally storage rally = playserToRally[_player];
    rally.valid = true;
    rally.stamps = new Stamp[](numStamps);
  }
  
  function collectStamp(uint8 position, string passphrase) public {
    Rally memory rally = playserToRally[msg.sender];
    if (!rally.valid) {
      initializeRally(msg.sender);
    }
    // todo
  }

  function getStamp(uint8 position) public view returns (string) {


  }
  
}
