pragma solidity 0.6;

interface IPoolFactory {
    function createPool(address) external returns (address);
}