pragma solidity ^0.5.0;

/// @title Stamp Rally
/// @author Ann Marie Kilzer
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

  /// @notice Emitted when a player collects a stamp
  event StampCollected(address indexed player,
		       uint8 position,
		       string url);

  /// @notice Emitted when a player makes an invalid guess
  event InvalidPassphrase(address indexed player,
			  uint8 position);
  
  constructor(uint8 _numStamps,
	      string memory _name) public {
    numStamps = _numStamps;
    stampKeys.length = numStamps;
    name = _name;
    owner = msg.sender;
  }

  // Checks if _position is within bounds of the stampKeys array
  modifier validPosition(uint8 _position) {
    // TODO
  }

  // Checks if msg.sender is the contract owner
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
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
    // TODO retrieve the stampKey from stampKeys
    // then set the hashedPassphrase, url, and prompt
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
    // TODO: calculate the hash
    StampKey memory sk = stampKeys[_position];
    // check if hash matches the stored passphrase
    if ( /*TODO*/) {
      RallyCard storage rc = cards[prc.id]; // Get the player's card
      rc.stamps[_position] = true; // record that they have the stamp!
      emit StampCollected(msg.sender, _position, sk.url); 
    } else {
      emit InvalidPassphrase(msg.sender, _position);
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
}
