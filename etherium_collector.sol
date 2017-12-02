pragma solidity ^0.4.0;

contract EtherCollector {
    
    address contract_owner;

    uint256 public constant ether_max_count = 100 ether;
    uint256 public ether_current_count;
    
    mapping(address => uint) public collection_history;
    
    function EtherCollector() public {
        ether_current_count = 0 ether;
        contract_owner = msg.sender;
    }
    
    function sendEther() public payable {
        if( msg.value < 1 ether || ether_current_count + msg.value > ether_max_count) {
            revert();
        }
        
        collection_history[msg.sender] = collection_history[msg.sender] + msg.value;
        ether_current_count = ether_current_count + msg.value;
        
        if(ether_current_count == ether_max_count){
            selfdestruct(contract_owner);
        }
    }
    
}