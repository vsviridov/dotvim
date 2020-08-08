set encoding=utf-8
scriptencoding utf-8

if &runtimepath ==# ''
  throw 'Empty ''runtimepath'''
endif
let $MYVIM = resolve(option#Split(&runtimepath)[0])

runtime! config/**/*.vim
