## Testing

First get your test addresses and private keys.

```
$ npx ganache-cli --account_keys_path keys.json
```

Start a fork of mainnet locally (using infura).

```
$ npx ganache-cli \
  -f https://mainnet.infura.io/v3/{API-KEY} \
  -m "clutch captain shoe salt awake harvest setup primary inmate ugly among become" \
  -i 1 \
  -u 0x39AA39c021dfbaE8faC545936693aC917d5E7563
```

Must be address of the cUSDC contract. :warning:

Seed some USDC to your wallet.

```
$ npm run seed
```
