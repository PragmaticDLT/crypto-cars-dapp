const CarManager = artifacts.require("CarManager");
const util = require("util");
const fs = require("fs");
const path = require("path");
const writeFile = util.promisify(fs.writeFile);

module.exports = async function(deployer) {
    await deployer.deploy(CarManager);

    const addresses = {
        carManager: CarManager.address
    };

    await writeFile(
        path.join(__dirname, "..", "build", "addresses.json"),
        JSON.stringify(addresses)
    );
};