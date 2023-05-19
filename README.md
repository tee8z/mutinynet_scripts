# mutinynet_scripts 
small collection of bash scripts and configuration files to make it easier to work with [mutinynet](https://blog.mutinywallet.com/mutinynet) as a backing to a cluster of lnd lightning nodes

assumes there is an external ssd mounted here: `/mount/ssd`

note, when building the bitcoind needed to connect with mutinynet, make sure to use the correct branch, ex:
```
git clone git@github.com:benthecarman/bitcoin.git
git checkout configure-signet-blockitme
```
once on the correct branch, the build instructions for bitcoind will work as normal

thank you for the team at mutiny in creating an easy to setup signet, making it easier to build/test application using lightning
