fs = require('fs')
path = require('path')
gulp = require('gulp')
jshint = require('gulp-jshint')
jsStylish = require('jshint-stylish')
stylint = require('gulp-stylint')
styStylish = require('stylint-stylish')
shell = require('gulp-shell')
yaml = require('js-yaml')
concat = require('gulp-concat')
uglify = require("gulp-uglify")
concatCss = require('gulp-concat-css')
cleanCss = require('gulp-clean-css')

# js语法检查 https://jshint.com/docs/options/
gulp.task 'lint:js', ->
  return gulp.src path.join(__dirname, './source/js/**/*.js')
    .pipe jshint()
    .pipe jshint.reporter(jsStylish)

# stylus语法检查 https://github.com/SimenB/stylint
gulp.task 'lint:stylus', ->
  return gulp.src path.join(__dirname, '/source/css/**/*.styl')
    .pipe stylint({
      rules: {},
      reporter: {
        reporter: 'stylint-stylish',
        reporterOptions: {
          verbose: true
        }
      }
    })
    .pipe stylint.reporter(styStylish)

# 配置文件检验
gulp.task 'validate:config', (cb) ->
  themeConfig = fs.readFileSync path.join(__dirname, '_config.yml')
  try
    yaml.safeLoad(themeConfig)
    cb()
  catch error
    cb new Error(error)

# 语言文件检验
gulp.task 'validate:languages', (cb) ->
  languagesPath = path.join __dirname, 'languages'
  languages = fs.readdirSync languagesPath
  errors = []

  for lang in languages
    languagePath = path.join languagesPath, lang
    try
      yaml.safeLoad fs.readFileSync(languagePath), {
        filename: path.relative(__dirname, languagePath)
      }
    catch error
      errors.push error

  if errors.length == 0
    cb()
  else
    cb(errors)

# 合并压缩js
gulp.task 'minify:js', ['lint:js'], (cb) ->
  return gulp.src([
    path.join(__dirname, 'source/js/src/bootstrap.js'),
    path.join(__dirname, 'source/js/src/gitment.browser.js'),
    path.join(__dirname, 'source/js/src/motion.js'),
    path.join(__dirname, 'source/js/src/post-details.js'),
    path.join(__dirname, 'source/js/src/scrollspy.js'),
    path.join(__dirname, 'source/js/src/utils.js'),
  ]).pipe concat('main.min.js')
    .pipe uglify()
    .pipe gulp.dest path.join __dirname, './source/js'

    
# 合并压缩js
gulp.task 'minify:css', ['lint:stylus'], (cb) ->
  return gulp.src([
    path.join(__dirname, 'source/css/src/main.css'),
    path.join(__dirname, '../../public/css/main.css'),
  ]).pipe concat('main.min.css')
    .pipe cleanCss()
    .pipe gulp.dest path.join __dirname, '../../public/css'

console.log path.join(__dirname, '../../public/css')

gulp.task 'default', [
  # 'validate:config',
  # 'validate:languages'
  'minify:js',
  'minify:css'
]