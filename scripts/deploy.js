
const hre = require("hardhat");
const ethers = hre.ethers;
async function main() {
    const excelcium = await ethers.deployContract("Excelcium");

    await excelcium.waitForDeployment();

    console.log(excelcium.target);

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });