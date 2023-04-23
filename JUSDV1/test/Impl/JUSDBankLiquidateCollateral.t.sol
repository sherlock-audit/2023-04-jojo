// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.9;

import "./JUSDBankInit.t.sol";
import "../../src/Impl/flashloanImpl/FlashLoanLiquidate.sol";
import "../mocks/MockChainLink900.sol";

contract JUSDBankLiquidateCollateralTest is JUSDBankInitTest {
    /// @notice user just deposit not borrow, account is safe
    function testLiquidateCollateralAccountIsSafe() public {
        mockToken1.transfer(alice, 10e18);
        vm.startPrank(alice);
        mockToken1.approve(address(jusdBank), 10e18);
        jusdBank.deposit(alice, address(mockToken1), 10e18, alice);
        bool ifSafe = jusdBank.isAccountSafe(alice);
        assertEq(ifSafe, true);
        vm.stopPrank();
        vm.startPrank(bob);
        cheats.expectRevert("ACCOUNT_IS_SAFE");
        bytes memory afterParam = abi.encode(address(jusd), 10e18);
        jusdBank.liquidate(
            alice,
            address(mockToken1),
            bob,
            10e18,
            afterParam,
            0
        );
        vm.stopPrank();
    }

    function testLiquidateCollateralAmountIsZero() public {
        mockToken1.transfer(alice, 10e18);
        vm.startPrank(address(jusdBank));
        jusd.transfer(bob, 5000e6);
        vm.stopPrank();
        vm.startPrank(alice);
        mockToken1.approve(address(jusdBank), 10e18);
        jusdBank.deposit(alice, address(mockToken1), 10e18, alice);
        jusdBank.borrow(5000e6, alice, false);
        vm.stopPrank();
        vm.startPrank(address(this));
        MockChainLinkBadDebt mockChainLinkBadDebt = new MockChainLinkBadDebt();
        JOJOOracleAdaptor jojoOracle3 = new JOJOOracleAdaptor(
            address(mockChainLinkBadDebt),
            20,
            86400,
            address(usdcPrice)
        );
        jusdBank.updateOracle(address(mockToken1), address(jojoOracle3));
        vm.stopPrank();
        vm.startPrank(bob);
        jusd.approve(address(jusdBank), 5225e6);
        vm.warp(3000);
        cheats.expectRevert("LIQUIDATE_AMOUNT_IS_ZERO");
        bytes memory afterParam = abi.encode(address(jusd), 5000e6);
        jusdBank.liquidate(alice, address(mockToken1), bob, 0, afterParam, 0);
    }

    function testLiquidateCollateralPriceProtect() public {
        mockToken1.transfer(alice, 10e18);
        vm.startPrank(address(jusdBank));
        jusd.transfer(bob, 5000e6);
        vm.stopPrank();
        vm.startPrank(alice);
        mockToken1.approve(address(jusdBank), 10e18);
        jusdBank.deposit(alice, address(mockToken1), 10e18, alice);
        jusdBank.borrow(7426e6, alice, false);
        vm.stopPrank();

        MockChainLink900 eth900 = new MockChainLink900();
        JOJOOracleAdaptor jojoOracle900 = new JOJOOracleAdaptor(
            address(eth900),
            20,
            86400,
            address(usdcPrice)
        );
        jusdBank.updateOracle(address(mockToken1), address(jojoOracle900));
        swapContract.addTokenPrice(address(mockToken1), address(jojoOracle900));

        jusd.mint(50000e6);
        IERC20(jusd).transfer(address(jusdExchange), 50000e6);
        FlashLoanLiquidate flashLoanLiquidate = new FlashLoanLiquidate(
            address(jusdBank),
            address(jusdExchange),
            address(USDC),
            address(jusd),
            insurance
        );

        bytes memory data = swapContract.getSwapData(
            10e18,
            address(mockToken1)
        );
        bytes memory param = abi.encode(
            swapContract,
            swapContract,
            address(bob),
            data
        );

        vm.startPrank(bob);
        bytes memory afterParam = abi.encode(
            address(flashLoanLiquidate),
            param
        );
        cheats.expectRevert("LIQUIDATION_PRICE_PROTECTION");
        // price 854.9999999885
        jusdBank.liquidate(
            alice,
            address(mockToken1),
            bob,
            10e18,
            afterParam,
            854e6
        );
    }

    function testSelfLiquidateCollateral() public {
        mockToken1.transfer(alice, 10e18);
        vm.startPrank(address(jusdBank));
        jusd.transfer(bob, 5000e6);
        vm.stopPrank();
        vm.startPrank(alice);
        mockToken1.approve(address(jusdBank), 10e18);
        jusdBank.deposit(alice, address(mockToken1), 10e18, alice);
        jusdBank.borrow(7426e6, alice, false);
        vm.stopPrank();
        vm.startPrank(address(this));
        MockChainLink900 eth900 = new MockChainLink900();
        JOJOOracleAdaptor jojoOracle900 = new JOJOOracleAdaptor(
            address(eth900),
            20,
            86400,
            address(usdcPrice)
        );
        jusdBank.updateOracle(address(mockToken1), address(jojoOracle900));
        swapContract.addTokenPrice(address(mockToken1), address(jojoOracle900));
        vm.stopPrank();

        vm.startPrank(alice);
        vm.warp(3000);

        bytes memory data = swapContract.getSwapData(1e18, address(mockToken1));
        bytes memory param = abi.encode(
            swapContract,
            swapContract,
            address(bob),
            data
        );
        FlashLoanLiquidate flashloanRepay = new FlashLoanLiquidate(
            address(jusdBank),
            address(jusdExchange),
            address(USDC),
            address(jusd),
            insurance
        );
        bytes memory afterParam = abi.encode(address(flashloanRepay), param);
        cheats.expectRevert("SELF_LIQUIDATION_NOT_ALLOWED");
        jusdBank.liquidate(
            alice,
            address(mockToken1),
            alice,
            10e18,
            afterParam,
            10e18
        );
    }

    function testLiquidateCollateralAmountIsTooBig() public {
        mockToken1.transfer(alice, 10e18);
        vm.startPrank(address(jusdBank));
        jusd.transfer(bob, 5000e6);
        vm.stopPrank();
        vm.startPrank(alice);
        mockToken1.approve(address(jusdBank), 10e18);
        jusdBank.deposit(alice, address(mockToken1), 10e18, alice);
        jusdBank.borrow(7426e6, alice, false);
        vm.stopPrank();
        vm.startPrank(address(this));
        MockChainLink900 eth900 = new MockChainLink900();
        JOJOOracleAdaptor jojoOracle900 = new JOJOOracleAdaptor(
            address(eth900),
            20,
            86400,
            address(usdcPrice)
        );
        jusdBank.updateOracle(address(mockToken1), address(jojoOracle900));
        swapContract.addTokenPrice(address(mockToken1), address(jojoOracle900));
        vm.stopPrank();

        vm.startPrank(bob);
        jusd.approve(address(jusdBank), 5225e6);
        vm.warp(3000);
        bytes memory data = swapContract.getSwapData(1e18, address(mockToken1));
        bytes memory param = abi.encode(
            swapContract,
            swapContract,
            address(bob),
            data
        );
        FlashLoanLiquidate flashloanRepay = new FlashLoanLiquidate(
            address(jusdBank),
            address(jusdExchange),
            address(USDC),
            address(jusd),
            insurance
        );
        bytes memory afterParam = abi.encode(address(flashloanRepay), param);
        cheats.expectRevert("LIQUIDATE_AMOUNT_IS_TOO_BIG");
        jusdBank.liquidate(
            alice,
            address(mockToken1),
            bob,
            11e18,
            afterParam,
            0
        );
    }

    function testLiquidatorIsNotInWhiteList() public {
        mockToken1.transfer(alice, 10e18);
        bool isOpen = jusdBank.isLiquidatorWhitelistOpen();
        assertEq(isOpen, false);
        jusdBank.liquidatorWhitelistOpen();
        vm.startPrank(alice);
        mockToken1.approve(address(jusdBank), 10e18);
        jusdBank.deposit(alice, address(mockToken1), 10e18, alice);
        jusdBank.borrow(7426e6, alice, false);
        vm.stopPrank();

        vm.startPrank(bob);
        vm.warp(3000);
        bytes memory data = swapContract.getSwapData(1e18, address(mockToken1));
        bytes memory param = abi.encode(
            swapContract,
            swapContract,
            address(bob),
            data
        );
        FlashLoanLiquidate flashloanRepay = new FlashLoanLiquidate(
            address(jusdBank),
            address(jusdExchange),
            address(USDC),
            address(jusd),
            insurance
        );
        bytes memory afterParam = abi.encode(address(flashloanRepay), param);
        cheats.expectRevert("LIQUIDATOR_NOT_IN_THE_WHITELIST");
        jusdBank.liquidate(
            alice,
            address(mockToken1),
            bob,
            1e18,
            afterParam,
            0
        );
    }

    // // Fuzzy test
    // //     function testLiquidateFuzzyLiquidatedTrader(address liquidatedTrader) public {
    // //         mockToken1.transfer(alice, 10e18);
    // //         vm.startPrank(alice);
    // //         mockToken1.approve(address(jusdBank), 10e18);
    // //         jusdBank.deposit(address(mockToken1), 10e18, alice);
    // //         jusdBank.liquidate(liquidatedTrader, address(mockToken1), 10e18, address(jusd), 10e18, alice);
    // //         vm.stopPrank();
    // //     }
    // //     function testLiquidateFuzzyLiquidationCollateral(address liquidationCollateral) public {
    // //         vm.startPrank(alice);
    // //         jusdBank.liquidate(alice, liquidationCollateral, 10e18, address(jusd), 5000e18, alice);
    // //     }

    // // //
    // //     function testLiquidateFuzzyLiquidationAmount(uint256 amount) public {
    // //         mockToken1.transfer(alice, 10e18);
    // //         vm.startPrank(address(jusdBank));
    // //         jusd.transfer(bob, 5000e18);
    // //         vm.stopPrank();
    // //         vm.startPrank(alice);
    // //         mockToken1.approve(address(jusdBank), 10e18);
    // //         jusdBank.deposit(address(mockToken1), 10e18, alice);
    // //         jusdBank.borrow(5000e18, alice, false, alice);
    // //         vm.stopPrank();
    // //         vm.startPrank(address(this));
    // //         MockChainLinkBadDebt mockChainLinkBadDebt = new MockChainLinkBadDebt();
    // //         JOJOOracleAdaptor jojoOracle3 = new JOJOOracleAdaptor(
    // //             address(mockChainLinkBadDebt),
    // //             20
    // //         );
    // //         jusdBank.updateOracle(address(mockToken1), address(jojoOracle3));
    // //         vm.stopPrank();

    // //         vm.startPrank(bob);
    // //         jusd.approve(address(jusdBank), 5225e18);
    // //         vm.warp(3000);
    // //         jusdBank.liquidate(alice, address(mockToken1), amount, address(jusd), 5000e18, bob);
    // //     }

    // //      function testLiquidateFuzzyDepositCollateral(address depositCollateral) public {
    // //         mockToken1.transfer(alice, 10e18);
    // //         vm.startPrank(address(jusdBank));
    // //         jusd.transfer(bob, 5000e18);
    // //         vm.stopPrank();
    // //         vm.startPrank(alice);
    // //         mockToken1.approve(address(jusdBank), 10e18);
    // //         jusdBank.deposit(address(mockToken1), 10e18, alice);
    // //         jusdBank.borrow(5000e18, alice, false, alice);
    // //         vm.stopPrank();
    // //         vm.startPrank(address(this));
    // //         MockChainLinkBadDebt mockChainLinkBadDebt = new MockChainLinkBadDebt();
    // //         JOJOOracleAdaptor jojoOracle3 = new JOJOOracleAdaptor(
    // //             address(mockChainLinkBadDebt),
    // //             20
    // //         );
    // //         jusdBank.updateOracle(address(mockToken1), address(jojoOracle3));
    // //         vm.stopPrank();

    // //         vm.startPrank(bob);
    // //         jusd.approve(address(jusdBank), 5225e18);
    // //         vm.warp(3000);
    // //         jusdBank.liquidate(alice, address(mockToken1), 10e18, depositCollateral, 5000e18, bob);
    // //     }

    // //      function testLiquidateFuzzyDepositAmount(uint256 depositAmount) public {
    // //         mockToken1.transfer(alice, 10e18);

    // //         vm.startPrank(address(jusdBank));
    // //         jusd.transfer(bob, depositAmount);
    // //         vm.stopPrank();

    // //         vm.startPrank(alice);
    // //         mockToken1.approve(address(jusdBank), 10e18);
    // //         jusdBank.deposit(address(mockToken1), 10e18, alice);
    // //         jusdBank.borrow(5000e18, alice, false, alice);
    // //         vm.stopPrank();

    // //         vm.startPrank(address(this));
    // //         MockChainLinkBadDebt mockChainLinkBadDebt = new MockChainLinkBadDebt();
    // //         JOJOOracleAdaptor jojoOracle3 = new JOJOOracleAdaptor(
    // //             address(mockChainLinkBadDebt),
    // //             20
    // //         );
    // //         jusdBank.updateOracle(address(mockToken1), address(jojoOracle3));
    // //         vm.stopPrank();

    // //         vm.startPrank(bob);
    // //         jusd.approve(address(jusdBank), depositAmount);
    // //         vm.warp(3000);
    // //         jusdBank.liquidate(alice, address(mockToken1), 10e18, address(jusd), depositAmount, bob);
    // //     }

    // //     function testLiquidateFuzzy2DepositAmount(uint256 depositAmount) public {
    // //         mockToken1.transfer(alice, 10e18);
    // //         mockToken2.transfer(bob, depositAmount);
    // //         vm.startPrank(alice);
    // //         mockToken1.approve(address(jusdBank), 10e18);
    // //         vm.warp(1000);
    // //         jusdBank.deposit(address(mockToken1), 10e18, alice);
    // //         vm.warp(2000);
    // //         jusdBank.borrow(5000e18, alice, false, alice);
    // //         vm.stopPrank();
    // //         vm.startPrank(address(this));
    // //         MockChainLinkBadDebt mockChainLinkBadDebt = new MockChainLinkBadDebt();
    // //         JOJOOracleAdaptor jojoOracle3 = new JOJOOracleAdaptor(
    // //             address(mockChainLinkBadDebt),
    // //             20
    // //         );
    // //         jusdBank.updateOracle(address(mockToken1), address(jojoOracle3));
    // //         vm.stopPrank();
    // //         vm.startPrank(bob);
    // //         mockToken2.approve(address(jusdBank), depositAmount);
    // //         vm.warp(3000);

    // //         jusdBank.liquidate(alice, address(mockToken1), 5e18, address(mockToken2), depositAmount, bob);
    // //         vm.stopPrank();
    // //     }

    // //      function testLiquidateFuzzyLiquidator(address liquidator) public {
    // //         mockToken1.transfer(alice, 10e18);
    // //         mockToken2.transfer(liquidator, 10e18);
    // //         vm.startPrank(alice);
    // //         mockToken1.approve(address(jusdBank), 10e18);
    // //         vm.warp(1000);
    // //         jusdBank.deposit(address(mockToken1), 10e18, alice);
    // //         vm.warp(2000);
    // //         jusdBank.borrow(5000e18, alice, false, alice);
    // //         vm.stopPrank();
    // //         vm.startPrank(address(this));
    // //         MockChainLinkBadDebt mockChainLinkBadDebt = new MockChainLinkBadDebt();
    // //         JOJOOracleAdaptor jojoOracle3 = new JOJOOracleAdaptor(
    // //             address(mockChainLinkBadDebt),
    // //             20
    // //         );
    // //         jusdBank.updateOracle(address(mockToken1), address(jojoOracle3));
    // //         vm.stopPrank();

    // //         vm.startPrank(liquidator);
    // //         mockToken2.approve(address(jusdBank), 10e18);
    // //         vm.warp(3000);
    // //         jusdBank.liquidate(alice, address(mockToken1), 5e18, address(mockToken2), 10e18, liquidator);
    // //         vm.stopPrank();
    // //     }
}
