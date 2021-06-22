## Testing

First run the following to get your test addresses and private keys.

```
$ npx ganache-cli --account_keys_path keys.json
```

Run the following to start a fork of mainnet locally.

```
$ npx ganache-cli \
  -f https://mainnet.infura.io/v3/{API-KEY} \
  -m "clutch captain shoe salt awake harvest setup primary inmate ugly among become" \
  -i 1 \
  -u 0x13c910af71d1fc565b49325071daa8bc66e47935
```
