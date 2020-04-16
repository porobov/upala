pragma solidity ^0.6.0;

import "./upala-score-provider.sol";
import "./base-prototype.sol";

// Full BladerunnerDAO is in playground/mvp.
// Here is the prototype BladerunnerDAO - controlled by a single person
contract BladerunnerDAO is UpalaScoreProvider, BasePrototype {

    uint256 defaultLimit = 1000000 * 10 ** 18;  // one million dollars [*places little finger near mouth*]

    constructor (
        address upalaProtocolAddress,
        address poolFactory
    ) UpalaScoreProvider (
        upalaProtocolAddress,
        poolFactory
    ) BasePrototype (
        '{"name": "BladerunnerDAO","version": "0.1","description": "Autoassigns FakeDAI score to anyone who joins","join-terms": "No deposit required (ignore the ammount you see and join)","leave-terms": "No deposit - no refund"}',
        2 * 10 ** 18,
        0
    )
    public {
        upala = Upala(upalaProtocolAddress);
        (groupID, groupPool) = upala.newGroup(address(this), poolFactory);
    }


    function announceAndSetBotReward(uint botReward) external {
        _announceAndSetBotReward(botReward);
    }

    function announceAndSetBotnetLimit(uint160 identityID, uint256 newBotnetLimit) external {
        _announceAndSetBotnetLimit(identityID, newBotnetLimit);
    }

    // with 3Box should be simple
    function getScoreByPath(uint160[] calldata path) external view returns (uint256) {
        // charge();
        // (address identityManager, uint256 score)
        // uint160[] memory memPath = path;
        // return upala.memberScore(memPath);
        return _getScoreByPath(path);
    }

    function getScoreByManager(address manger) external view returns (address, uint256) {
        uint160[] memory path = new uint160[](2);
        path[0] = identityIDs[manger];
        path[1] = groupID;
        uint256 score = _getScoreByPath(path);
        address holder = _getIdentityHolder(path[0]);
        return (holder, score);
        // charge();
        //(uint160 identityID, uint256 score)
    }

}