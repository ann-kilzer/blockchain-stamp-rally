let StampRally = artifacts.require("StampRally");
let numStamps = 12;
let pic = "https://en.wikipedia.org/wiki/Kangaroo_rat#/media/File:Kangaroo-rat.jpg";

module.exports = function(deployer) {

    deployer.deploy(StampRally, numStamps, "Blockchain Stamp Rally");

    let rally;
    deployer.then(function() {
	return StampRally.deployed();
    }).then(function(instance) {
	rally = instance;
    }).then(function() {
	return rally.generateHash("password")
    }).then(function(hash) {
	for (let i = 0; i < numStamps; i++) {
	    rally.setStamp(i, hash, pic);
	    
	}
    })




    
 
};
