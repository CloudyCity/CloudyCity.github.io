fs = require('fs')
path = require('path')
gulp = require('gulp')
jshint = require('gulp-jshint') # js语法检查
jslish = require('jshint-stylish') # js语法检查输出美化
stylint = require('gulp-stylint') # stylus语法检查
stylish = require('stylint-stylish') # stylus语法检查输出美化
yaml = require('js-yaml')
concat = require('gulp-concat') # js合并
uglify = require("gulp-uglify") # js压缩
concatCss = require('gulp-concat-css') # css合并
cleanCss = require('gulp-clean-css') # css压缩

# js语法检查 https://jshint.com/docs/options/
gulp.task 'lint:js', ->
  return gulp.src path.join(__dirname, './source/js/**/*.js')
    .pipe jshint()
    .pipe jshint.reporter()

# stylus语法检查 https://github.com/SimenB/stylint
gulp.task 'lint:stylus', ->
  return gulp.src path.join(__dirname, '/source/css/**/*.styl')
    .pipe stylint({config: path.join(__dirname, '.stylintrc')})
    .pipe stylint.reporter(stylish)

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
# gulp.task 'minify:js', ['lint:js'], (cb) ->
gulp.task 'minify:js', (cb) ->
  return gulp.src([
    path.join(__dirname, 'source/js/src/utils.js'),
    path.join(__dirname, 'source/js/src/motion.js'),
    path.join(__dirname, 'source/js/src/gitment.browser.js'),
    path.join(__dirname, 'source/js/src/bootstrap.js'),
    path.join(__dirname, 'source/js/src/scrollspy.js'),
    path.join(__dirname, 'source/js/src/post-details.js'),
  ]).pipe concat('main.min.js')
    .pipe uglify()
    .pipe gulp.dest(path.join __dirname, '../../public/js')

# 合并压缩js
# gulp.task 'minify:css', ['lint:stylus'], (cb) ->
gulp.task 'minify:css', (cb) ->
  return gulp.src([
    path.join(__dirname, '../../public/css/main.css'),
    path.join(__dirname, 'source/css/src/gitment.css'),
  ]).pipe concat('main.min.css')
    .pipe cleanCss()
    .pipe gulp.dest(path.join __dirname, '../../public/css')

# 执行
gulp.task 'default', [
  'validate:config',
  'validate:languages'
  'minify:js',
  'minify:css',
]