pragma solidity 0.7.5;
 
import "./Ownable.sol"
 
contract Bank is Ownable {
 
  mapping(address => uint) balance;
 
  event depositDone(uint amount, address indexed depositTo);
 
  modifier costs(uint price) {
      require(msg.value > price);
      _; //run the function
  }
 
  function deposit() public payable returns (uint) {
      balance[msg.sender] += msg.value; //(cd be removed)(for keep track the balance. nothing to do balance of contract itself)
      emit depositDone(msg.value, msg.sender);
      return balance[msg.sender];
  }
 
  function withdraw(uint amount) public onlyOwner returns (uint){
      msg.sender.transfer(amount);
  }
 
  function getBalance() public view returns (uint){
      return balance[msg.sender];
  }
 
  function transfer(address recipient, uint amount) public {
      require(balance[msg.sender] >= amount, "Balance not sufficient");
      require(msg.sender != recipient, "Don't transfer money to yourself");
 
      //B4 transfer, state prev balance
      uint previousSenderBalance = balance[msg.sender];
     
      //go thru transfer
      _transfer(msg.sender, recipient, amount);
 
      //post-transfer balance
      assert(balance[msg.sender] == previousSenderBalance - amount);
 
      //event logs and further checks
  }
 
  function _transfer(address from, address to, uint amount) private {
      balance[from] -= amount;
      balance[to] += amount;
  }
 
}
