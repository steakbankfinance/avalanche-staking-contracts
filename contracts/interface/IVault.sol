pragma solidity ^0.6.0;

interface IVault {

    function claimAVAX(uint256 amount, address payable recipient) external returns(uint256);

}