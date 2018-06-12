pragma solidity ^0.4.21;

import "./CarFactory.sol";

contract CarManager is CarFactory {
    function changeName(uint _carId, string _newName) external onlyOwner() {
        cars[_carId].name = _newName;
    }

    function getCarIds(address _owner) external view returns(uint[]) {
        uint[] memory carIds = new uint[](ownerCarCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < cars.length; i++) {
            if (carToOwner[i] == _owner) {
                carIds[counter] = i;
                counter++;
            }
        }

        return carIds;
    }

    function getCarById(uint _carId) external view returns(string name, string outerColor, string innerColor) {
        Car storage car = cars[_carId];

        return (car.name, car.outerColor, car.innerColor);
    }

}
