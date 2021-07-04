const Compound = require("@compound-finance/compound-js");
import { VercelRequest, VercelResponse } from "@vercel/node";

const compound = new Compound("http://127.0.0.1:8545", {
  privateKey:
    "0xb8c1b5c1d81f9475fdf2e334517d29f733bdfa40682207571b12fc1142cbf329"
});

// const result = await contract.getAccountLiquidity(walletAddress);
// const { 0: error, 1: liquidity, 2: shortfall } = result;

// console.log(error);
// console.log(liquidity, BigNumber.from(liquidity._hex).toString());
// console.log(shortfall);
async function borrowUSDC(amount: number) {
  console.log("Borrowing USDC on compound.");

  try {
    if (isNaN(amount) || amount === 0) {
      throw Error("insufficuent amount");
    }
    const asset = Compound.USDC;
    const trxEnterMarkets = await compound.enterMarkets(asset);
    const trxBorrow = await compound.borrow(asset, amount);
    console.log("Borrow", asset, amount);
    console.log(trxEnterMarkets.hash);
    console.log(trxBorrow.hash);
    return {
      trx: trxBorrow.hash,
      error: null
    };
  } catch (error) {
    console.log(error);
    return {
      trx: null,
      error
    };
  }
}

export default async (req: VercelRequest, res: VercelResponse) => {
  if (req.body === undefined || req.body.amount === undefined) {
    res.status(400).json({ error: "No amount provided." });
    return;
  }

  const { trx, error } = await borrowUSDC(req.body.amount);
  res.json({
    trx,
    error
  });
};
