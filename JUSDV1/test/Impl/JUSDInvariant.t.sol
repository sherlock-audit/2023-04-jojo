// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.9;

import "./JUSDBankInit.t.sol";
import "../mocks/MockToken.sol";
import "forge-std/console2.sol";

contract JUSDInvariantTest is JUSDBankInitTest {
    //     reserveAmount <= maxAmount
    //    function invariant_ReservesAmount() public {
    //        assertTrue(jusdBank.reservesAmount() <= jusdBank.maxReservesAmount());
    //    }
    //
    //    function invariant_TotalBorrowAmount() public {
    //        emit log_uint(1);
    //        assertTrue(jusdBank.t0TotalBorrowAmount() <= jusdBank.maxTotalBorrowAmount());
    //    }
}
