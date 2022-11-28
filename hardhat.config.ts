import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

import { getApiUrl, getPrivateKey, getPolygonScanApiKey } from "./Environment";

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  defaultNetwork: "maticmum",
  networks: {
    hardhat: {},
    maticmum: {
      url: getApiUrl(),
      accounts: [`0x${getPrivateKey()}`]
    },
  },
  etherscan: {
    apiKey: getPolygonScanApiKey()
  }
};

export default config;
