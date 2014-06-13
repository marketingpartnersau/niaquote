module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
	
	coffee: {
	  compile:{
  		files: {
        'app/js/quote.js' : 'app/coffee/quote.coffee',
        'app/js/util.js' : 'app/coffee/util.coffee',
  		}
	  }
	},

  copy: {
    main: {
      expand: true,
      cwd: 'bower_components/',
      src: '**/*.js',
      dest: 'app/js/vendor'
    },
  },

  watch: {
    grunt: { files: ['Gruntfile.js'] },

    coffee: {
    	files: 'app/coffee/**/*.coffee',
    	tasks: ['coffee'],
    	options: {
    	  livereload: true,
    	}
    },

    markup: {
      files: ['*.php', '**/*.php'],
      options: {
        livereload: true,
      }
    }
      
  }
});
  
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.registerTask('build', ['coffee']);
  grunt.registerTask('default', ['watch']);
  //grunt.registerTask('default', ['copy', 'uglify', 'concat', 'watch']);

}