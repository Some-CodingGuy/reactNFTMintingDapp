const hre = require("hardhat");

async function main() {

  const ManifoldExtensionLazyMint = await hre.ethers.getContractFactory("ManifoldExtensionLazyMint2");
  const manifoldExtensionLazyMint = await ManifoldExtensionLazyMint.deploy(); // If the cnstructor of the NFT would need some parameters we could pass them here and they would be passed to the constructer when deployed

  await manifoldExtensionLazyMint.deployed();

  console.log("ManifoldExtensionLazyMint deployed to:", manifoldExtensionLazyMint.address.toLowerCase());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
