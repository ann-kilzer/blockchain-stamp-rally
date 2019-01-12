module.exports = {
    files: {
	javascripts: {
	    joinTo: {
		'js/vendor.js': /^node_modules/,
		'js/app.js': ['app/init.js', 'app/App.vue']
	    }
	},
	templates: {
	    joinTo: {
		'app.js' : 'app/App.vue'
		    }
	},
	stylesheets: {
	    joinTo: {
		'css/app.css': ['app/css/styles.css'],
		'css/vendor.css': /^node_modules/
	    }
	},
    },
}
