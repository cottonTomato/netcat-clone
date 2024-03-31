project('mnc', 'c',
  version : '0.1',
  default_options : ['warning_level=3'])

czmq_dep = dependency('libczmq', version: '>=4.2.1')

executable('mnc-socket', 'mnc.c')

executable('mnc-czmq', 'mnc-czmq.c', dependencies: czmq_dep)
