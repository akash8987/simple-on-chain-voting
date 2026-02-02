// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        string name;
        uint256 voteCount;
    }

    mapping(address => bool) public hasVoted;
    Proposal[] public proposals;

    constructor(string[] memory proposalNames) {
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function vote(uint256 proposalIndex) public {
        require(!hasVoted[msg.sender], "Already voted.");
        require(proposalIndex < proposals.length, "Invalid proposal.");

        hasVoted[msg.sender] = true;
        proposals[proposalIndex].voteCount += 1;
    }

    function getWinner() public view returns (string memory winnerName) {
        uint256 winningVoteCount = 0;
        uint256 winningIndex = 0;

        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningIndex = i;
            }
        }
        winnerName = proposals[winningIndex].name;
    }
}
