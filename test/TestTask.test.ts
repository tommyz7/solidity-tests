import hre from 'hardhat';
import {expect} from 'chai';

const { ethers, deployments, getNamedAccounts } = hre;
const { deploy } = deployments;

describe('TestTask @ethereum', function () {
  let test: any;
  let deployer: any;
  let deployerSigner: any;

  before(async function () {
    const namedAccounts = await getNamedAccounts();
    deployer = namedAccounts.deployer;

    deployerSigner = await ethers.provider.getSigner(deployer);
  });

  beforeEach(async function () {
    const TestTask = await ethers.getContractFactory('TestTask')
    test = await TestTask.deploy()
    await test.deployed();
  });

  it('buildStringByTemplate()', async function () {
    const createKeccakHash = require('keccak')

    function toChecksumAddress (address: any) {
      address = address.toLowerCase().replace('0x', '')
      var hash = createKeccakHash('keccak256').update(address).digest('hex')
      console.log('address', address)
      console.log('hash', hash)
      var ret = '0x'

      for (var i = 0; i < address.length; i++) {
        console.log('hash[i]', hash[i]);
        console.log('parseInt(hash[i], 16)', parseInt(hash[i], 16));
        if (parseInt(hash[i], 16) >= 8) {
          ret += address[i].toUpperCase()
        } else {
          ret += address[i]
        }
      }

      return ret
    }

    expect(await test.addressToString("0xca35b7d915458ef540ade6068dfe2f44e8fa733c")).to.be.equal("0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c");
  });

  it('trimMirroringChars()', async function () {
    expect(await test.trimMirroringChars(["apple", "electricity", "year"])).to.be.equal("appectricitear");
    expect(await test.trimMirroringChars(["ethereum", "museum", "must", "tree"])).to.be.equal("etheresesree");
    expect(await test.trimMirroringChars(["talk", "kayak", "kayaking"])).to.be.equal("taling");
    expect(await test.trimMirroringChars(["talk", "k", "l"])).to.be.equal("tall");
    expect(await test.trimMirroringChars(["talk", "", "l"])).to.be.equal("talkl");
    expect(await test.trimMirroringChars(["kayak", "kayaking", "gnil"])).to.be.equal("l");
  });
});
