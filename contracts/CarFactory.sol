pragma solidity ^0.4.21;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract CarFactory is Ownable {

    event NewCar(uint carId, string name, string outerColor, string innerColor);

    struct Car {
        string name;
        string outerColor;
        string innerColor;
    }

    Car[] public cars;

    mapping (uint => address) public carToOwner;

    mapping (address => uint) ownerCarCount;

    function _createCar(string _name, string _outerColor, string _innerColor) internal {
        uint id = cars.push(Car(_name, _outerColor, _innerColor));
        carToOwner[id] = msg.sender;
        ownerCarCount[msg.sender]++;
        emit NewCar(id, _name, _outerColor, _innerColor);
    }

    function createNewCar(string _name, string _outerColor, string _innerColor) public {
        _createCar(_name, _outerColor, _innerColor);
    }
}