var StampRally = artifacts.require("StampRally.sol");

const should = require('chai').should();

contract('StampRally', function(accounts) {

    let prefix = "http://www.example.com/stamp_rally/";
    let numStamps = 12;
    
    let rally;
    
    beforeEach(async function () {
	rally = await StampRally.new(numStamps, prefix);
    });

    describe("constructor", async function() {
	it("should make a new stamp rally", async function() {
	    assert.equal((await rally.prefix()), prefix, "Prefix didn't match");
	    assert.equal((await rally.numStamps()).toNumber(), numStamps, "NumStamps didn't match");
	});
    });

    describe("collect stamp", async function() {
	it("should create a rally if one doesn't exist yet", async function() {

	});
    });
});
