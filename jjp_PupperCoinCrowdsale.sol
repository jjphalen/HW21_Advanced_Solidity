pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


contract PupperCoinCrowdsale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    constructor (
        uint256 rate,
        address payable wallet,
        PupperCoin token,
        uint256 cap,
        uint256 openingTime,
        uint256 closingTime,
        uint256 goal
     )
    CappedCrowdsale(cap)
    TimedCrowdsale(openingTime, closingTime)
    RefundableCrowdsale(goal)
    Crowdsale(rate, wallet, token)
    public {
    }
}

contract PupperCoinSaleDeployer {
    
    address public pupper_sale_address;
    address public token_address;
    
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    ) 
    
        public {
        
        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);
        
        PupperCoinCrowdsale pupper_sale = new PupperCoinCrowdsale(1, wallet, token, 1000, now, now + 24 weeks, 10000);
        pupper_sale_address = address(pupper_sale);
        
        token.addMinter(pupper_sale_address);
        token.renounceMinter();
    }
}