const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log(`배포하는 계정 주소: ${deployer.address}`);

  // 컨트랙트 팩토리 가져오기
  const NFTContract = await ethers.getContractFactory("NFTContract");

  // 컨트랙트 배포
  const nft = await NFTContract.deploy();

  // 배포 완료를 기다림
  await nft.waitForDeployment();

  console.log(`NFT 컨트랙트 배포 완료: ${nft.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
