pragma solidity 0.5.0;

/// @title Stamp Rally
/// @author Ann Marie Kilzer
/// @notice You can use this contract for only the most basic simulation
/// @dev All function calls are currently implemented without side effects
contract StampRally {
  uint8 public numStamps;
  string public name;

  // Ownership for the game manager of the contract
  address public owner;
  address public pendingOwner;

  // A StampKey keeps track of every stamp in the game
  struct StampKey {
    // The hashedPassphrase keeps the keccak256 encoded passphrase
    bytes32 hashedPassphrase;
    string url;
    string prompt;
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

  constructor(uint8 _numStamps,
	      string memory _name) public {
    numStamps = _numStamps;
    stampKeys.length = numStamps;
    name = _name;
    owner = msg.sender;
  }

  modifier validPosition(uint8 _position) {
    require(_position < numStamps); // in bounds
    _;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /// @notice Allows a game manager to transfer ownership
  /// @dev Note that ownership won't transfer until the newOwner calls claimOwnership
  /// @param newOwner The new game manager
  function transferOwnership(address newOwner) public onlyOwner {
    pendingOwner = newOwner;
  }

  /// @notice Allows the pending game manager to claim ownership 
  function claimOwnership() public {
    require(msg.sender == pendingOwner);
    owner = pendingOwner;
  }

  /// @notice Allows the game manager to set up a stamp
  /// @param _position The index of the stamp
  /// @param _hashedPassphrase The hashed passphrase from a call to generateHash
  /// @param _url The URL of the stamp image
  /// @param _prompt A text hint for the passphrase
  function setStamp(uint8 _position,
		    bytes32 _hashedPassphrase,
		    string memory _url,
		    string memory _prompt) public validPosition(_position) onlyOwner {
    StampKey storage s = stampKeys[_position];
    s.hashedPassphrase = _hashedPassphrase;
    s.url = _url;
    s.prompt = _prompt;
  }

  /// @notice Computes the keccak256 hash of the passphrase
  /// @dev Note this is intentionally an unsalted hash
  /// @param _passphrase the raw passphrase
  /// @return the hashed passphrase
  function generateHash(string memory _passphrase) public pure returns (bytes32 hashed) {
    return keccak256(abi.encode(_passphrase));
  }

  /// @notice Submits a passphrase in an attempt to collect a stamp on behalf of the player
  /// @dev player determined by msg.sender
  /// @param _position the index of the stamp
  /// @param _passphrase the raw passphrase
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

  /// @notice Retrieves a stamp url if the user has collected the stamp
  /// @dev Technically, msg.sender can be forged on view functions... honor system ;)
  /// @param _position the index of the stamp
  /// @return the saved stamp url if the user has collected the stamp, otherwise an empty string
  function getStampImage(uint8 _position) public view returns (string memory) {
    if (userHasStamp(_position, msg.sender)) {
      StampKey memory sk = stampKeys[_position];
      return sk.url;
    }
    return "";
  }

  /// @notice Retrives a text hint for the passphrase 
  /// @param _position the index of the stamp
  /// @return stamp prompt
  function getStampPrompt(uint8 _position) public view validPosition(_position) returns (string memory) {
    StampKey memory sk = stampKeys[_position];
    return sk.prompt;
  }

  /// @notice Checks if the user has the stamp
  /// @param _position the index of the stamp
  /// @param _user The ethereum address of the player
  /// @return true if the user has collected the stamp
  function userHasStamp(uint8 _position, address _user) public view validPosition(_position) returns (bool stamp) {
    PlayerRallyCard memory prc = playerToRallyCard[_user];
    if(!prc.valid) {
      return false;
    }
    RallyCard memory rc = cards[prc.id];
    return rc.stamps[_position];
  }
}
