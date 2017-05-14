var gulp = require('gulp'),
  less = require('gulp-less'),
  concat = require('gulp-concat'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename'),
  connect = require('gulp-connect'),
  slim = require('gulp-slim'),
  cleanCss = require('gulp-clean-css'),
  coffee = require('gulp-coffee');

/**
 * Compile LESS
 */
gulp.task('less', function () {
  return gulp.src([
      'app/less/main.less'
    ])
    .pipe(less())
    .pipe(concat('main.css'))
    .pipe(cleanCss())
    .pipe(gulp.dest('public/css'))
    .pipe(connect.reload());
});

/**
 * Concat and Min
 */
gulp.task('scripts', function () {
  return gulp.src('app/coffee/**/*.coffee')
    .pipe(coffee({bare : true}))
    .pipe(concat('app.js'))
    .pipe(uglify())
    .pipe(gulp.dest('public/js'))
    .pipe(connect.reload());
});

/**
 * Slim
 */
gulp.task('slim', function () {
  return gulp.src([
      'app/slim/header.slim',
      'app/slim/sidebar/header.slim',
      'app/slim/sidebar/history.slim',
      'app/slim/sidebar/footer.slim',
      'app/slim/main-wrap.slim',
      'app/slim/components/requester.slim',
      'app/slim/templates.slim',
      'app/slim/footer.slim',
    ])
    .pipe(concat('index.html'))
    .pipe(slim())
    .pipe(gulp.dest('public'))
    .pipe(connect.reload());
});

/**
 * Watch Files
 */
gulp.task('watch', function () {
  gulp.watch('app/coffee/**/*.coffee', ['scripts']);
  gulp.watch(['app/less/**/*.less'], ['less']);
  gulp.watch(['app/slim/**/*.slim'], ['slim']);
});

/**
 * Move vendor files
 */
gulp.task('vendor', function () {
  return gulp.src([
      'node_modules/guid/guid.js'
    ])
    .pipe(uglify())
    .pipe(gulp.dest('public/js/vendor'));
});

/**
 * Move assets
 */
gulp.task('assets', function () {
  return gulp.src(['app/img/**/*'])
    .pipe(gulp.dest('public/img'));
});

/**
 * Start Server
 */
gulp.task('serve', function () {
  connect.server({
    root : 'public',
    port : 8888,
    livereload : true
   });
 });

/**
 * Command Line Tasks
 */
gulp.task('default', ['vendor', 'assets', 'less', 'scripts', 'slim', 'watch', 'serve']);
gulp.task('build', ['vendor', 'assets', 'less', 'scripts', 'slim']);
