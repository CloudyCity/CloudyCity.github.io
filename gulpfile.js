require('coffeescript/register')
require('./themes/next/gulpfile.coffee')

// var gulp = require('gulp')
// var concat = require('gulp-concat')
// var uglify = require("gulp-uglify")

// gulp.task('minify:js', ['lint:js'], function(cb) {
//   return gulp.src([
//     './themes/next/source/js/src/bootstrap.js',
//     './themes/next/source/js/src/gitment.browser.js',
//     './themes/next/source/js/src/motion.js',
//     './themes/next/source/js/src/post-details.js',
//     './themes/next/source/js/src/scrollspy.js',
//     './themes/next/source/js/src/utils.js',
//   ]).pipe(concat('main.js'))
//     .pipe(uglify())
//     .pipe(gulp.dest('./themes/next/source/js'))
//   });

// gulp.task('default', [
//   'lint:js',
//   'minify:js',
//   'lint:stylus',
//   'validate:config',
//   'validate:languages'
// ]);