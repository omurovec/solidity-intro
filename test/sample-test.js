const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

describe("Token", function () {
  it("Should deploy the Token contract", async function () {
    const Token = await ethers.getContractFactory("Token");
    const token = await Token.deploy("MyToken", "TKN");

    expect(await token.name()).to.equal("MyToken");
    expect(await token.symbol()).to.equal("TKN");
    expect(await token.totalSupply()).to.equal(100);
  });

  describe("Transfer", function () {
    it("Should allow owner to send token", async function () {
      const Token = await ethers.getContractFactory("Token");
      const token = await Token.deploy("MyToken", "TKN");

      const [owner, alice] = await ethers.getSigners();

      await token.transfer(alice.address, 100);
      expect(await token.balanceOf(owner.address)).to.equal(0);
      expect(await token.balanceOf(alice.address)).to.equal(100);
    });
  });
});
