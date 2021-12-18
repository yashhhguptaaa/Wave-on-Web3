const main = async () => {
    // const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy({
        value : hre.ethers.utils.parseEther('0.1'),
    });
    await waveContract.deployed();

    console.log("Contract add to:",waveContract.address);
    // console.log("Contract deployed by:",owner.address);

    /*
    Get Contract balance
   */

    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );

    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
      );


    // let waveCount;
    // waveCount = await waveContract.getTotalWaves();
    // console.log(waveCount[1].toNumber());

    let waveTxn = await waveContract.wave("Hi, This is a message! #1");
    await waveTxn.wait();

     waveTxn = await waveContract.wave("Hi, This is a message! #2");
    await waveTxn.wait();

    /*
        Get Contract balance to see what happened!
   */
    
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );
    // const [_, randomPerson] = await hre.ethers.getSigners();
    // waveTxn = await waveContract.connect(randomPerson).wave("Hi, This is another message");
    // await waveTxn.wait();
    
    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);

};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();