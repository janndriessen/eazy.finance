const Compound = require("@compound-finance/compound-js");
import { VercelRequest, VercelResponse } from "@vercel/node";

const compound = new Compound("http://127.0.0.1:8545", {
  privateKey:
    "0xb8c1b5c1d81f9475fdf2e334517d29f733bdfa40682207571b12fc1142cbf329"
});

async function calculateApy(asset: string) {
  const srpb = await Compound.eth.read(
    Compound.util.getAddress("c" + asset),
    "function supplyRatePerBlock() returns (uint256)",
    [],
    { provider: compound.provider }
  );

  const mantissa = Math.pow(10, 18);
  const blocksPerDay = (60 * 60 * 24) / 13.15; // ~13.15 second block time
  const daysPerYear = 365;

  const supplyApy =
    (Math.pow((+srpb.toString() / mantissa) * blocksPerDay + 1, daysPerYear) -
      1) *
    100;
  return supplyApy;
}

export default async (_: VercelRequest, res: VercelResponse) => {
  const asset = "USDC";
  const apy = await calculateApy(asset);
  console.log(apy);
  res.json({
    apy,
    asset
  });
};
