const hre = require("hardhat");

async function main() {
  const Token = await hre.ethers.getContractFactory("Token");
  const token = await Token.deploy("myToken", "TKN");

  await token.deployed();
  await token.mint(200);

  console.log("Token deployed to:", token.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
