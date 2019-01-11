module.exports = {
    files: {
	javascripts: {
	    joinTo: {
		'vendor.js': /node_modules/,
		'app.js': ['app/*.js', 'app/*.vue']
	    }
	},
	stylesheets: {
	    joinTo: {
		'css/app.css': ['app/css/styles.css'],
		'css/vendor.css': /^node_modules/
	    }
	},
    },
    plugins: {
	babel: {
	}
    }
}
