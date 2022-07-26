### Forge Setup:

1. To create new project in existing github repo:

```
> forge init --force --no-commit
```

2. To import packages:

```
a. > forge install Openzeppelin/openzeppelin-contracts --no-commit

b. Add REMAPPING in foundry.toml :
remappings = ["forge-std/=lib/forge-std/src/","@openzeppelin/=lib/openzeppelin-contracts/"]
```

Now, we can import @openzeppelin contracts.

3. To compile contracts present in ./src folder
```
> forge build
```

4. To run tests present in ./test folder (with verbose enabled)
```
> forge test -vvvvv
```

5. To run script in ./script folder to deploy and invoke contracts methods on tv4 network
```
export RPC_URL="<tv4 rpc url>"
export PRIVATE_KEY="<PK>"
> forge script script/ElvOwnable.s.sol:ElvOwnableScript --fork-url ${RPC_URL} --private-key ${PRIVATE_KEY} --broadcast --legacy
```

We have `--legacy` enabled as it considers latest london fork enabled (wih EIP 1559 enabled).