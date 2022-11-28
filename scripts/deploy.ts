import { ethers } from 'hardhat';

async function deploy() {
    const EcoToken = await ethers.getContractFactory("EcoToken");

    const ecoToken = await EcoToken.deploy(20_000_000);
    console.log(`Contract deployed to: ${ecoToken.address}`);
}

deploy().then(
    () => {
        process.exit(0);
    }
).catch((error)=>{
    console.log(error);
    process.exit(1);
})