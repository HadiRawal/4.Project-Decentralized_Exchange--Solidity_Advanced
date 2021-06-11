// *** First we need to build wallet *** //

pragma solidity >=0.6.0 <0.8.0; //to be compatible with openzeppelin

import '../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '../node_modules/@openzeppelin/contracts/math/SafeMath.sol';

contract Wallet {
    using SafeMath for uint256;
    
    //Storage for the Token: contains (1. ticker (symbol) & tokenAddress)
    //e.g. ticker is ETH, tokenAddress is 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 
    struct Token{
        bytes32 ticker;
        address tokenAddress;
    }
    
    mapping(bytes32 => Token) public tokenMapping;
    bytes32[] public tokenList; 
    
    // Balances: Double Mapping for Balances to support different types of ERC20 tokens
    //      Address 
    mapping(address => mapping(bytes32 => uint256)) public balances;

    function addToken (bytes32 ticker, address tokenAddress) external {
        tokenMapping[ticker] = Token(ticker, tokenAddress);
        tokenList.push(ticker); 
    }

    function deposit(uint amount, bytes32 ticker) external {

    } 

    function withdraw(amount, ticker);(uint amount, bytes32 ticker) external {
        //Secured Pattern: CHECKS-EFFECTS-INTERACTIONS
        //1.1 CHECKS:the token is exist?
        require(tokenMapping[ticker].tokenAddress != address(0));
        //1.2 CHECKS:the balance is sufficient? 
        require(balances[msg.sender][ticker] => amount, "Balance not sugfficient");
        //2.  EFFECTS:etting the contract before the execution.
        //    Use SafeMath to avoid overflow and underflow
        balances[msg.sender][ticker] = balances[msg.sender][ticker].sub(amount);
        //3.  INTERACTIONS: execute the task
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender,amount);

    }

}