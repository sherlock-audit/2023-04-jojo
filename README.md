
# [project name] contest details

- Join [Sherlock Discord](https://discord.gg/MABEWyASkp)
- Submit findings using the issue page in your private contest repo (label issues as med or high)
- [Read for more details](https://docs.sherlock.xyz/audits/watsons)

# Q&A

# Audit scope


[JUSD @ 85e46334977042b9497aa5d1e5820c81791cf1a9](https://github.com/JOJOexchange/JUSD/tree/85e46334977042b9497aa5d1e5820c81791cf1a9)
- [JUSD/src/Impl/FlashLoanLiquidate.sol](JUSD/src/Impl/FlashLoanLiquidate.sol)
- [JUSD/src/Impl/FlashLoanRepay.sol](JUSD/src/Impl/FlashLoanRepay.sol)
- [JUSD/src/Impl/JOJOOracleAdaptor.sol](JUSD/src/Impl/JOJOOracleAdaptor.sol)
- [JUSD/src/Impl/JUSDBank.sol](JUSD/src/Impl/JUSDBank.sol)
- [JUSD/src/Impl/JUSDBankStorage.sol](JUSD/src/Impl/JUSDBankStorage.sol)
- [JUSD/src/Impl/JUSDExchange.sol](JUSD/src/Impl/JUSDExchange.sol)
- [JUSD/src/Impl/JUSDMulticall.sol](JUSD/src/Impl/JUSDMulticall.sol)
- [JUSD/src/Impl/JUSDOperation.sol](JUSD/src/Impl/JUSDOperation.sol)
- [JUSD/src/Impl/JUSDView.sol](JUSD/src/Impl/JUSDView.sol)
- [JUSD/src/Interface/IChainLinkAggregator.sol](JUSD/src/Interface/IChainLinkAggregator.sol)
- [JUSD/src/Interface/IFlashLoanReceive.sol](JUSD/src/Interface/IFlashLoanReceive.sol)
- [JUSD/src/Interface/IJUSDBank.sol](JUSD/src/Interface/IJUSDBank.sol)
- [JUSD/src/Interface/IJUSDExchange.sol](JUSD/src/Interface/IJUSDExchange.sol)
- [JUSD/src/Interface/IPriceChainLink.sol](JUSD/src/Interface/IPriceChainLink.sol)
- [JUSD/src/Interface/IWETH.sol](JUSD/src/Interface/IWETH.sol)
- [JUSD/src/lib/DataTypes.sol](JUSD/src/lib/DataTypes.sol)
- [JUSD/src/lib/DecimalMath.sol](JUSD/src/lib/DecimalMath.sol)
- [JUSD/src/lib/JOJOConstant.sol](JUSD/src/lib/JOJOConstant.sol)
- [JUSD/src/token/JUSD.sol](JUSD/src/token/JUSD.sol)
- [JUSD/src/utils/FlashLoanReentrancyGuard.sol](JUSD/src/utils/FlashLoanReentrancyGuard.sol)
- [JUSD/src/utils/GeneralRepay.sol](JUSD/src/utils/GeneralRepay.sol)
- [JUSD/src/utils/JUSDError.sol](JUSD/src/utils/JUSDError.sol)
- [JUSD/src/utils/UniswapPriceAdaptor.sol](JUSD/src/utils/UniswapPriceAdaptor.sol)
- [JUSD/src/utils/emergencyOracle.sol](JUSD/src/utils/emergencyOracle.sol)

[smart-contract-EVM @ a212216ea1e3ca3bb8168300774d3e029fd7a6bf](https://github.com/JOJOexchange/smart-contract-EVM/tree/a212216ea1e3ca3bb8168300774d3e029fd7a6bf)
- [smart-contract-EVM/contracts/adaptor/chainlinkAdaptor.sol](smart-contract-EVM/contracts/adaptor/chainlinkAdaptor.sol)
- [smart-contract-EVM/contracts/adaptor/constOracle.sol](smart-contract-EVM/contracts/adaptor/constOracle.sol)
- [smart-contract-EVM/contracts/adaptor/emergencyOracle.sol](smart-contract-EVM/contracts/adaptor/emergencyOracle.sol)
- [smart-contract-EVM/contracts/adaptor/uniswapPriceAdaptor.sol](smart-contract-EVM/contracts/adaptor/uniswapPriceAdaptor.sol)
- [smart-contract-EVM/contracts/fundingRateKeeper/FundingRateUpdateLimiter.sol](smart-contract-EVM/contracts/fundingRateKeeper/FundingRateUpdateLimiter.sol)
- [smart-contract-EVM/contracts/impl/JOJODealer.sol](smart-contract-EVM/contracts/impl/JOJODealer.sol)
- [smart-contract-EVM/contracts/impl/JOJOExternal.sol](smart-contract-EVM/contracts/impl/JOJOExternal.sol)
- [smart-contract-EVM/contracts/impl/JOJOOperation.sol](smart-contract-EVM/contracts/impl/JOJOOperation.sol)
- [smart-contract-EVM/contracts/impl/JOJOStorage.sol](smart-contract-EVM/contracts/impl/JOJOStorage.sol)
- [smart-contract-EVM/contracts/impl/JOJOView.sol](smart-contract-EVM/contracts/impl/JOJOView.sol)
- [smart-contract-EVM/contracts/impl/Perpetual.sol](smart-contract-EVM/contracts/impl/Perpetual.sol)
- [smart-contract-EVM/contracts/intf/IDealer.sol](smart-contract-EVM/contracts/intf/IDealer.sol)
- [smart-contract-EVM/contracts/intf/IDecimalERC20.sol](smart-contract-EVM/contracts/intf/IDecimalERC20.sol)
- [smart-contract-EVM/contracts/intf/IMarkPriceSource.sol](smart-contract-EVM/contracts/intf/IMarkPriceSource.sol)
- [smart-contract-EVM/contracts/intf/IPerpetual.sol](smart-contract-EVM/contracts/intf/IPerpetual.sol)
- [smart-contract-EVM/contracts/lib/EIP712.sol](smart-contract-EVM/contracts/lib/EIP712.sol)
- [smart-contract-EVM/contracts/lib/Funding.sol](smart-contract-EVM/contracts/lib/Funding.sol)
- [smart-contract-EVM/contracts/lib/Liquidation.sol](smart-contract-EVM/contracts/lib/Liquidation.sol)
- [smart-contract-EVM/contracts/lib/Operation.sol](smart-contract-EVM/contracts/lib/Operation.sol)
- [smart-contract-EVM/contracts/lib/Position.sol](smart-contract-EVM/contracts/lib/Position.sol)
- [smart-contract-EVM/contracts/lib/Trading.sol](smart-contract-EVM/contracts/lib/Trading.sol)
- [smart-contract-EVM/contracts/lib/Types.sol](smart-contract-EVM/contracts/lib/Types.sol)
- [smart-contract-EVM/contracts/subaccount/Subaccount.sol](smart-contract-EVM/contracts/subaccount/Subaccount.sol)
- [smart-contract-EVM/contracts/subaccount/SubaccountFactory.sol](smart-contract-EVM/contracts/subaccount/SubaccountFactory.sol)
- [smart-contract-EVM/contracts/utils/Errors.sol](smart-contract-EVM/contracts/utils/Errors.sol)
- [smart-contract-EVM/contracts/utils/SignedDecimalMath.sol](smart-contract-EVM/contracts/utils/SignedDecimalMath.sol)


