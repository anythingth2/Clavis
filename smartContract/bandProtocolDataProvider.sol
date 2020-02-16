pragma solidity >=0.5.14;
pragma experimental ABIEncoderV2;

library BandChainLib {
  function toUint64List(bytes memory _data) internal pure returns(uint64[] memory) {
    uint64[] memory result = new uint64[](_data.length / 8);
    require(result.length * 8 == _data.length, "DATA_LENGTH_IS_INVALID");

    for (uint256 i = 0; i < result.length; i++) {
      uint64 tmp;
      assembly {
        tmp := mload(add(_data, add(0x08, mul(i, 0x08))))
      }
      result[i] = tmp;
    }

    return result;
  }
}


interface IBridge {
  /// Helper struct to help the function caller to decode oracle data.
  struct VerifyOracleDataResult {
    bytes data;
    bytes32 codeHash;
    bytes params;
  }

  /// Performs oracle state relay and oracle data verification in one go. The caller submits
  /// the encoded proof and receives back the decoded data, ready to be validated and used.
  /// @param _data The encoded data for oracle state relay and data verification.
  function relayAndVerify(bytes calldata _data)
    external
    returns (VerifyOracleDataResult memory result);
}


contract bandProtocolDataProvider {
    
  using BandChainLib for bytes;

  bytes32 public codeHash;
  bytes public params;
  
  uint256 public latestValue;
  uint256 public timeStamp;

  IBridge public bridge;

  constructor(bytes32 _codeHash , bytes memory _params, IBridge _bridge) public {
    codeHash = _codeHash;
    params = _params;
    bridge = _bridge;
  }

  function update(bytes memory _reportValue) public {
    IBridge.VerifyOracleDataResult memory result = bridge.relayAndVerify(_reportValue);

    require(result.codeHash == codeHash, "INVALID_CODEHASH");
    require(keccak256(result.params) == keccak256(params), "INVALID_PARAMS");

    uint64[] memory decodedInfo = result.data.toUint64List();

    require(uint256(decodedInfo[1]) > timeStamp, "TIMESTAMP_IS_OLDER_THAN_THE_LAST_UPDATE");

    latestValue = uint256(decodedInfo[0]);
    timeStamp = uint256(decodedInfo[1]);
  }
  
  function setCodeHash(bytes32 _codeHash) public {
      codeHash = _codeHash;
  }
  function setParams(bytes memory _params) public {
      params = _params;
  }
}
