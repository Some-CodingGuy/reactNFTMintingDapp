const hre = require("hardhat");

async function main() {

  const SelfDevsNFT = await hre.ethers.getContractFactory("SelfDevsNFT");
  const selfDevsNFT = await SelfDevsNFT.deploy(); // If the cnstructor of the NFT would need some parameters we could pass them here and they would be passed to the constructer when deployed

  await selfDevsNFT.deployed();

  console.log("SelfDevsNFT deployed to:", selfDevsNFT.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
