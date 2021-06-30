const Compound = require("@compound-finance/compound-js");

const address = "0xa0df350d2637096571F7A701CBc1C5fdE30dF76A";

const compound = new Compound("http://127.0.0.1:8545", {
  privateKey:
    "0xb8c1b5c1d81f9475fdf2e334517d29f733bdfa40682207571b12fc1142cbf329"
});

const borrow = async function() {
  try {
    const daiScaledUp = "1000000000000000000000";
    const trxOptions = { mantissa: false };

    console.log("Borrowing 32 USDC...");
    const trx = await compound.borrow(Compound.USDC, 10, trxOptions);

    console.log("Ethers.js transaction object", trx);
  } catch (error) {
    console.log(error);
  }
};

const supply = async function() {
  try {
    console.log(Compound.USDC, Compound.cUSDC);
    console.log(Compound.ETH);
    const cUsdtAddress = Compound.util.getAddress(Compound.cUSDT);
    console.log(cUsdtAddress);
    // const daiScaledUp = "1000000000000000000000";
    // const trxOptions = { mantissa: true };
    console.log("Supplying ETH to the Compound Protocol...");
    const trx = await compound.supply(Compound.USDC, 10);
    console.log("Ethers.js transaction object", trx);
    // const trx2 = await compound.borrow(Compound.USDC, 1000);
    // console.log("Ethers.js transaction object", trx2);
  } catch (error) {
    console.log(error);
  }
};

const main = async function() {
  console.log("cETH ABI: ", Compound.util.getAbi("cErc20"));

  // const account = await Compound.api.account({
  //   addresses: address,
  //   network: "http://127.0.0.1:8545"
  // });

  console.log("here");
  // console.log(account.accounts);
  let usdcSupplyBalance = 0;
  // if (Object.isExtensible(account) && account.accounts) {
  // account.accounts.forEach((acc: any) => {
  //   console.log(acc.address);
  //   acc.tokens.forEach((tok: any) => {
  //     if (tok.symbol === Compound.cUSDC) {
  //       usdcSupplyBalance = +tok.supply_balance_underlying.value;
  //     }
  //   });
  // });
  // }

  console.log("usdc supply balance", usdcSupplyBalance);
};

const accrued = async function() {
  const acc = await Compound.comp.getCompAccrued(address);
  console.log("Accrued", acc);
};

// borrow();
// main();
supply();
// accrued();
