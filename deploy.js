const hre = require("hardhat");

async function main() {
  const proposals = ["Bitcoin", "Ethereum", "Solana"];
  const Voting = await hre.ethers.getContractFactory("Voting");
  const voting = await Voting.deploy(proposals);

  await voting.waitForDeployment();

  console.log(`Voting contract deployed to: ${await voting.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
