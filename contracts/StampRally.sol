pragma solidity 0.5.0;


contract StampRally {
  uint8 public numStamps;
  
  struct StampKey {
    bytes32 hashedPassphrase;
    string url;
  }

  // All the hashed passphrases are stored here 
  StampKey[] internal stampKeys;
  
  // Represents one users Stamp Rally "Card" 
  struct RallyCard {
    bool[] stamps;
  }

  // all cards in the game
  RallyCard[] internal cards;

  // links to a Rally Card
  struct PlayerRallyCard {
    uint64 id;
    bool valid;
  }

  // lookup table between player addresses and card id
  mapping (address => PlayerRallyCard) public playerToRallyCard;

  constructor(uint8 _numStamps) public {
    numStamps = _numStamps;
    stampKeys.length = numStamps;
  }

  modifier validPosition(uint8 _position) {
    require(_position < numStamps); // in bounds
    _;
  }
  
  function setStamp(uint8 _position, bytes32 _hashedPassphrase, string memory _url) public validPosition(_position) {
    StampKey storage s = stampKeys[_position];
    s.hashedPassphrase = _hashedPassphrase;
    s.url = _url;
  }

  // Unsalted hash
  function generateHash(string memory _passphrase) public pure returns (bytes32 hashed) {
    return keccak256(abi.encode(_passphrase));
  }
  
  function collectStamp(uint8 _position, string memory _passphrase) public validPosition(_position) {
    PlayerRallyCard memory prc = playerToRallyCard[msg.sender];
    if (!prc.valid) {
      uint64 max = 2**64 - 1;
      require(cards.length < max, "Reached maximum number of players");
      // make a new card
      uint64 id = uint64(cards.length);
      bool[] memory s = new bool[](numStamps);
      cards.push(RallyCard(s));
      playerToRallyCard[msg.sender] = PlayerRallyCard(id, true);
    }
    bytes32 hash = generateHash(_passphrase);
    StampKey memory sk = stampKeys[_position];
    if (hash == sk.hashedPassphrase) {
      RallyCard storage rc = cards[prc.id];
      rc.stamps[_position] = true;
    }
  }

  // retrieves a stamp url for the sender
  function getStampImage(uint8 _position) public view returns (string memory) {
    if (userHasStamp(_position, msg.sender)) {
      StampKey memory sk = stampKeys[_position];
      return sk.url;
    }
    return "";
  }

  function userHasStamp(uint8 _position, address _user) public view validPosition(_position) returns (bool stamp) {
    PlayerRallyCard memory prc = playerToRallyCard[_user];
    if (!prc.valid) {
      return false;
    }
    RallyCard memory rc = cards[prc.id];
    return rc.stamps[_position];
  }
  
}
