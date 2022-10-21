pragma solidity 0.7.5;

contract Destroyable {
    address public owner;

    modifier onlyOwner {
      require(msg.sender == owner);
      _; //run the function
    }

    constructor(){
      owner = msg.sender;
    }

    function store(address) public {
        number = num;
    }
 
    function retrieve() public view returns (address){
        return number;
    }
 
    function close() public { 
        selfdestruct(owner); 
    }
}