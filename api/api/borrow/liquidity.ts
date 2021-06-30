import { BigNumber } from "bignumber.js";
import { ethers, providers } from "ethers";
import { VercelRequest, VercelResponse } from "@vercel/node";

const contractAddress = "0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B";
const provider = new providers.JsonRpcProvider("http://localhost:8545");

// Comptroller
const abi = [
  // Read-Only Functions
  "function getAccountLiquidity(address account) view returns (uint, uint, uint)",
  "function markets(address cTokenAddress) view returns (bool, uint, bool)"
];

export default async (req: VercelRequest, res: VercelResponse) => {
  if (req.body === undefined || req.body.amount === undefined) {
    res.status(400).json({ error: "No borrow amount provided." });
    return;
  }

  const amount = req.body.amount;
  const cTokenAddress = "0x39AA39c021dfbaE8faC545936693aC917d5E7563";
  const contract = new ethers.Contract(contractAddress, abi, provider);

  const market = await contract.markets(cTokenAddress);
  const { 1: collateralFactorMantissa } = market;

  let collateralFactor = new BigNumber(collateralFactorMantissa.toString());
  collateralFactor = collateralFactor.shiftedBy(-18);
  const collateralFactorSafetyAdjusted = collateralFactor
    .minus(0.05)
    .toNumber();
  console.log(
    amount,
    collateralFactorMantissa,
    collateralFactor.toNumber(),
    collateralFactorSafetyAdjusted
  );

  // amount divided by collateral factor minus safety of 5%
  // we would never want to get our user liquidated
  // (probably there is a better way to calc this)
  const collateral = amount / collateralFactorSafetyAdjusted;
  res.json({
    borrowAmount: amount,
    collateralNeeded: Math.ceil(collateral)
  });
};
