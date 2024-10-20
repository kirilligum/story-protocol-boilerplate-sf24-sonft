## Story - Smart Contract Tutorial

This repository should be used to help developers get started with building on top of Story's smart contracts. It includes a simple contract used for IP registration of mock ERC-721 NFTs, and accompanying tests.

## Documentation

Find the full smart contract guide here: https://docs.story.foundation/docs/get-started-with-the-smart-contracts

## Get Started

1. `yarn`

2. Run the tests

    2a. Run all the tests: `forge test --fork-url https://testnet.storyrpc.io/`

    2b. Run a specific test: `forge test --fork-url https://testnet.storyrpc.io/ --match-path test/IPALicenseTerms.t.sol`

## walrus storage of images

```

kirill@koldun ~/t/royalty (main)> curl -X PUT "$PUBLISHER/v1/store?epochs=5" --upload-file shana.jpg
{"alreadyCertified":{"blobId":"gYD_vr-MNccxSFl4r1PKW0nzpfkz4FIaDr9zQxguriA","eventOrObject":{"Event":{"txDigest":"61WuqEpAuQZDaPvhKCHG3MTR6MV2pjVVpvSVY3QVRZHN","eventSeq":"0"}},"endEpoch":10}}⏎
```



```
kirill@koldun ~/t/royalty (main)> curl -X PUT "$PUBLISHER/v1/store?epochs=5" --upload-file helenadress.jpg
{"newlyCreated":{"blobObject":{"id":"0x327c1d3d2a8420c774a51b510dbe755d62e97e3cdb63ae263de7913c0b26b85e","registeredEpoch":5,"blobId":"V0BhF9UGsDJvstZ441tbp_GYctDzqkeZrB4lKQm6Ugg","size":106481,"encodingType":"RedStuff","certifiedEpoch":5,"storage":{"id":"0x2ae6454a973f99a74213e3a52232c3d4b66c6119814e3a7fa4ddd23e38c7649e","startEpoch":5,"endEpoch":10,"storageSize":65023000},"deletable":false},"resourceOperation":{"RegisterFromScratch":{"encoded_length":65023000,"epochs_ahead":5}},"cost":157500}}kirill@koldun ~/t/royalty (main)>
```
