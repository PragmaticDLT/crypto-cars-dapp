pragma solidity ^0.4.21;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Basic.sol";
import "./CarFactory.sol";

contract CarOwnership is CarFactory, ERC721Basic {

    using SafeMath for uint256;

    mapping (uint => address) carApprovals;

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerCarCount[_owner];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerCarCount[_to] = ownerCarCount[_to].add(1);
        ownerCarCount[msg.sender] = ownerCarCount[msg.sender].sub(1);
        carToOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transfer(address _to, uint256 _tokenId) public onlyOwner() {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public onlyOwner() {
        carApprovals[_tokenId] = _to;

        emit Approval(msg.sender, _to, _tokenId);
    }

    function takeOwnership(uint256 _tokenId) public {
        require(carApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}
