//SPDX-license-Identifier: MIT
pragma solidity ^0.8.20;

contract MyFinalProposal {
    address public owner;
    string public tittle;
    string public description;

    uint public yesVotes;
    uint public noVotes;

    enum ProposalState {
        Pending, Accepted, Rejected
    }
    ProposalState public state;

    mapping(address => bool) public hasVoted;

    constructor(string memory _tittle, string memory _description) {
        owner = msg.sender;
        tittle = _tittle;
        description = _description;
        state = ProposalState.Pending;
    }

    modifier onlyOwner() {
        require(msg.sender == owner , "Only can do this");
        _;
    }

    function voteYes() public {
        require(!hasVoted[msg.sender], "you already voted");
        hasVoted[msg.sender] = true;
        yesVotes++;
        updateState();
    }

    function updateState() internal {
        if (yesVotes + noVotes >= 5) {
            if (yesVotes > noVotes) {
               state = ProposalState.Accepted; 
            } else {
                state = ProposalState.Rejected;
            }
        }   
    }

    /// @notice Returns the current state of the proposal as a readable string 
    /// @return The current state: "pending" , "Accepted", or "Rejected"get
    function getProposalState() public view returns (string memory) {
        if (state == ProposalState.Pending) return "pending";
        if (state == ProposalState.Accepted) return "Accepted";
        return "Rejected";
    }
}
