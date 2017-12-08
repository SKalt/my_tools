#! /usr/bin/env bash
# https://code.lengstorf.com/learn-rollup-js/

function usage {
    cat <<EOM
Usage: add_rollup [ -h | --help ]
    a script to initiate rollup functionality in a node module.  Run once 
    without arguments to set up .babelrc and rollup.config.js. If they already
    exist, they will be left as is.

    -h | --help : get this usage message
EOM
    exit 0
}

while [ "$1" != "" ]; do
    case $1 in
        -h | --help )          usage
                               exit
                               ;;
        * )                    usage
                               exit 1
    esac
    shift
done

if ! [ -a "package.json" ] ; then
    npm init;
fi

# install babel/
npm install --save-dev            \
    rollup                        \
    rollup-plugin-babel           \
    @babel/preset-env             \
    @babel/core
    babel-plugin-external-helpers \
    rollup-plugin-eslint          \
    rollup-plugin-node-resolve    \
    rollup-plugin-commonjs        \
    rollup-plugin-uglify          \
    rollup-plugin-replace

# init
if ! [ -a "rollup.config.js" ] ; then
    cat > "rollup.config.js" <<EOF
import babel from 'rollup-plugin-babel';
import eslint from 'rollup-plugin-eslint';
import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';
import replace from 'rollup-plugin-replace';
import uglify from 'rollup-plugin-uglify';

export default {
  entry: 'src/scripts/main.js',
  dest: 'build/js/main.min.js',
  format: 'iife',
  sourceMap: 'inline',
  plugins: [
    resolve({
      jsnext: true,
      main: true,
      browser: true,
    }),
    commonjs(),
    eslint({
      exclude: [
        'src/styles/**',
      ]
    }),
    babel({
      exclude: 'node_modules/**',
    }),
    replace({
      ENV: JSON.stringify(process.env.NODE_ENV || 'development'),
    }),
    (process.env.NODE_ENV === 'production' && uglify()),
  ],
};
EOF
fi

if ! [ -a ".babelrc.json" ] ; then
    cat > ".babelrc.json" <<EOF
{
  "presets": [
    [
      "es2015",
      {
        "modules": false
      }
    ]
  ],
  "plugins": [
    "external-helpers"
  ]
}
EOF
fi

./node_modules/.bin/eslint --init

exit 0



