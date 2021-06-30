const Compound = require("@compound-finance/compound-js");
import { VercelRequest, VercelResponse } from "@vercel/node";

const compound = new Compound("http://127.0.0.1:8545", {
  privateKey:
    "0xb8c1b5c1d81f9475fdf2e334517d29f733bdfa40682207571b12fc1142cbf329"
});

async function supplyUSDC(amount: number) {
  try {
    if (isNaN(amount) || amount === 0) {
      throw Error("insufficuent amount");
    }
    const asset = "USDC";
    const trx = await compound.supply(asset, amount);
    console.log("Supply USDC", amount, trx);
    console.log("Transaction Hash", trx.hash);
    return {
      trx: trx.hash,
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

  const { trx, error } = await supplyUSDC(req.body.amount);
  res.json({
    trx,
    error
  });
};
