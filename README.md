# Test-contracts

1. To compile contracts present in ./src folder
```
> forge build
```

2. To run tests present in ./test folder (with verbosity enabled)
```
> forge test -vvvvv
```

3. To run script in ./script folder to deploy and invoke contracts methods on tv4 network
```
export RPC_URL="<tv4 rpc url>"
export PRIVATE_KEY="<PK>"
> forge script script/ElvOwnable.s.sol:ElvOwnableScript --fork-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast --legacy
```

We have `--legacy` enabled as it considers latest london fork (wih EIP 1559) enabled.

More details on setup [here](./notes/forge_setup.md).

