
# [project name] contest details

- Join [Sherlock Discord](https://discord.gg/MABEWyASkp)
- Submit findings using the issue page in your private contest repo (label issues as med or high)
- [Read for more details](https://docs.sherlock.xyz/audits/watsons)

# Q&A

### Q: On what chains are the smart contracts going to be deployed?
Arbitrum
___

### Q: Which ERC20 tokens do you expect will interact with the smart contracts? 
USDC, WETH, WBTC, ARB
___

### Q: Which ERC721 tokens do you expect will interact with the smart contracts? 
none
___

### Q: Which ERC777 tokens do you expect will interact with the smart contracts? 
none
___

### Q: Are there any FEE-ON-TRANSFER tokens interacting with the smart contracts?

no
___

### Q: Are there any REBASING tokens interacting with the smart contracts?

no
___

### Q: Are the admins of the protocols your contracts integrate with (if any) TRUSTED or RESTRICTED?
TRUSTED
___

### Q: Is the admin/owner of the protocol/contracts TRUSTED or RESTRICTED?
TRUSTED
___

### Q: Are there any additional protocol roles? If yes, please explain in detail:
no
___

### Q: Is the code/contract expected to comply with any EIPs? Are there specific assumptions around adhering to those EIPs that Watsons should be aware of?
expected to comply with any EIPs
___

### Q: Please list any known issues/acceptable risks that should not result in a valid finding.
1. Centralization Risk: The administration holds excessive authority, with roles such as FundingRateKeeper, JOJO operation, valid orderSender, emergency oracle owner, and insurance account, all utilizing multi-sig protocols.
2. Incompatibility with Deflationary Tokens: The primary and secondary assets are standard ERC20 tokens.
3.Low-level Call: Regarding the execution of Subaccount operations.
4. Unused Contract: During delisting, the oracle will be replaced to anchor the price at a fixed value.
5. Missing Zero Address Validation: Zero address validation is absent in Subaccount#owner, ChainlinkAdaptor#_chainlink,FundingRateUpdateLimiter#dealer, etc.
6. Removal of 'Perpetual': Delisting the perpetual is the standard procedure.
7. Reliability of Price: Ensuring the reliability of price data.
8. Third Party Dependencies: Potential failures of the Chainlink Oracle.
9. Potential Reentrancy Attack:
    a. _settle() after 'IDealer(owner()).requestLiquidation'.
    b. Change of 'secondaryCredit' after 'IERC20(state.primaryAsset).safeTransfer(to, 
    primaryAmount);' in funding.sol.
    c. Change of secondaryAsset after 'IDecimalERC20(_secondaryAsset).decimals()' in Operation.sol.
10. Open positions are discarded if 'Perpetual' is deregistered, only when no position is held.
11. Signature can be replayed: Backend will add nonce to the order type to prevent replay attacks.
12. Address Poisoning Attack: Caused by users' incorrect address copying, and the team cannot provide assistance in such cases.
13. DOS attack possible for trading:
    a. Only valid msg.sender can call approveTrade. If there are too many orders that 
   cannot be matched, they will be divided into multiple transactions.
    b. _realizePnl function loops over an unbounded array within the openPositions 
   mapping, but there is a limit on the number of registered perpetuals to avoid 
   reaching the block gas limit.
14. setOperator function is missing the onlyOwner modifier: This function is designed for users to set their own operator, so no need for the onlyOwner modifier.
15. Did not Approve to zero first (USDT, we only use USDC in JUSDBank system).
16. Collateral Token is a standard ERC20 token.
17. FlashloanRepay, FlashloanLiquidate, GeneralRepay aare only implemented for functional purposes, regardless of accidental transfers by users.
18. JUSD system operates under a cross-margin mode, where appreciated collateral can be obtained during the liquidation process if users are not safe.
19.Asset losses of less than 1e-3 USDC due to precision loss are not considered.
___

### Q: Please provide links to previous audits (if any).
https://skyharbor.certik.com/report/9ab2b9e7-442b-44ff-8545-d448370eee88?findingIndex=summary

https://www.slowmist.com/service-smart-contract-security-audit.html
___

### Q: Are there any off-chain mechanisms or off-chain procedures for the protocol (keeper bots, input validation expectations, etc)?
JOJO is a decentralized perpetual contract exchange based on an off-chain matching system. There are more details in here: https://jojo-docs.netlify.app/

JOJO is especially interested in losses/malfunctioning related to MEV.  
___

### Q: In case of external protocol integrations, are the risks of external contracts pausing or executing an emergency withdrawal acceptable? If not, Watsons will submit issues related to these situations that can harm your protocol's functionality.
We use Chainlink and niswap as oracle price source. If the oracle is pausing, we still have emergency oracle so that do not worry about it.
hainlink Oracle Failed
___



# Audit scope
