const hre = require("hardhat");

async function main() {
    const excelcium = await hre.ethers.getContractAt("Excelcium", "0xceE1BC3a386893D610435d380Bb79F37DF8076CC");
    const balance = await excelcium.balanceOf("0x002C65Be429d430DF090f2DC847df3b468676029");
    console.log(balance.toString());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });