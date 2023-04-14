
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
1.Centralization Risk: admin have excessive authority,including:FundingRateKeeper role, JOJO operation role, valid orderSender, emergency oracle owner, insurance account. All have used multi-sig.
2. Incompatibility with Deflationary Tokens: primary asset and secondary asset are standard ERC20 token
3. Low-level Call: About the execute operation of Subaccount.
4.Missing Zero Address Validation
5. Transaction Order Dependency 
6.setOperator function is missing onlyOwner modifier: this function is aiming to set every user own operator so no need modifier
7. Arbitrary Storage Write: we have contract owner to control it
8. Users can request a withdrawal of a huge amount which is impossible to execute.
9. DOS attack possible for trading: 
    1. only valid msg.sender can call **approveTrade.** If there are too many orders and cannot be matched, we will divide them into multiple transactions.
    2. _realizePnl function loops over an unbounded array within the `openPositions` mapping: every user in every registered perpetual just only have one position. We have a limit on the number of registered perpetual so we pretty sure it will not reach a block gas limit
10. Address Poisoning Attack

___

### Q: Please provide links to previous audits (if any).
https://skyharbor.certik.com/report/9ab2b9e7-442b-44ff-8545-d448370eee88?findingIndex=summary

https://www.slowmist.com/service-smart-contract-security-audit.html
___

### Q: Are there any off-chain mechanisms or off-chain procedures for the protocol (keeper bots, input validation expectations, etc)?
JOJO is a decentralized perpetual contract exchange based on an off-chain matching system. There are more details in here: https://jojo-docs.netlify.app/
___

### Q: In case of external protocol integrations, are the risks of external contracts pausing or executing an emergency withdrawal acceptable? If not, Watsons will submit issues related to these situations that can harm your protocol's functionality.
We use chainlink and uniswap as oracle price source. If the oracle is pausing, we still have emergency oracle so that do not worry about it.
chainlink Oracle Failed
___



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
1.Centralization Risk: admin have excessive authority,including:FundingRateKeeper role, JOJO operation role, valid orderSender, emergency oracle owner, insurance account. All have used multi-sig.
2. Incompatibility with Deflationary Tokens: primary asset and secondary asset are standard ERC20 token
3. Low-level Call: About the execute operation of Subaccount.
4.Missing Zero Address Validation
5. Transaction Order Dependency 
6.setOperator function is missing onlyOwner modifier: this function is aiming to set every user own operator so no need modifier
7. Arbitrary Storage Write: we have contract owner to control it
8. Users can request a withdrawal of a huge amount which is impossible to execute.
9. DOS attack possible for trading: 
    1. only valid msg.sender can call **approveTrade.** If there are too many orders and cannot be matched, we will divide them into multiple transactions.
    2. _realizePnl function loops over an unbounded array within the `openPositions` mapping: every user in every registered perpetual just only have one position. We have a limit on the number of registered perpetual so we pretty sure it will not reach a block gas limit
10. Address Poisoning Attack

___

### Q: Please provide links to previous audits (if any).
https://skyharbor.certik.com/report/9ab2b9e7-442b-44ff-8545-d448370eee88?findingIndex=summary

https://www.slowmist.com/service-smart-contract-security-audit.html
___

### Q: Are there any off-chain mechanisms or off-chain procedures for the protocol (keeper bots, input validation expectations, etc)?
JOJO is a decentralized perpetual contract exchange based on an off-chain matching system. There are more details in here: https://jojo-docs.netlify.app/
___

### Q: In case of external protocol integrations, are the risks of external contracts pausing or executing an emergency withdrawal acceptable? If not, Watsons will submit issues related to these situations that can harm your protocol's functionality.
We use chainlink and uniswap as oracle price source. If the oracle is pausing, we still have emergency oracle so that do not worry about it.
chainlink Oracle Failed
___



# Audit scope
