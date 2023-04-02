require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    bnbtestnet: {
      url: "https://hidden-blissful-energy.bsc-testnet.discover.quiknode.pro/68486184a04cc36c79046419b8a84db0fccb5841/",
      accounts: [
        "78055a5ed0820db872de3f8364ced719769034b8bccfd39bb0ca495a4684f97f",
      ],
    },
  },
  etherscan: {
    apiKey: "563IE5QEN9XKU3PG622EQIU6K75PWVWC2D", //etherscan API KEY
  },
};
