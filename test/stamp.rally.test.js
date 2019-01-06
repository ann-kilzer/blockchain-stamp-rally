var StampRally = artifacts.require("StampRally.sol");

const should = require('chai').should();

contract('StampRally', function(accounts) {

    let prefix = "http://www.example.com/stamp_rally/";
    let numStamps = 6;

    // Flora and Fauna of New Mexico, USA
    let p0 = "coyote"
    let p1 = "armadillo"
    let p2 = "roadrunner"
    let p3 = "chola cactus"
    let p4 = "pancake prickly pear"
    let p5 = "kangaroo rat"


    let h0, h1, h2, h3, h4, h5;
    
    let rally;
    
    beforeEach(async function () {
	rally = await StampRally.new(numStamps, prefix);
	h0 = await rally.generateHash(p0);
	h1 = await rally.generateHash(p1);
	h2 = await rally.generateHash(p2);
	h3 = await rally.generateHash(p3);
	h4 = await rally.generateHash(p4);
	h5 = await rally.generateHash(p5);

	rally.setPassphraseForStamp(0, h0);
	rally.setPassphraseForStamp(1, h1);
	rally.setPassphraseForStamp(2, h2);
	rally.setPassphraseForStamp(3, h3);
	rally.setPassphraseForStamp(4, h4);
	rally.setPassphraseForStamp(5, h5);
	
    });

    describe("constructor", async function() {
	it("should make a new stamp rally", async function() {
	    assert.equal((await rally.prefix()), prefix, "Prefix didn't match");
	    assert.equal((await rally.numStamps()).toNumber(), numStamps, "NumStamps didn't match");
	});
    });

    describe("collect stamp", async function() {
	it("should create a rally if one doesn't exist yet", async function() {
	    await rally.collectStamp(2, p2);
	});
    });
});
