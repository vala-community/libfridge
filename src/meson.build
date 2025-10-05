conf = configuration_data()
conf.set('prefix', get_option('prefix'))
conf.set('libdir', get_option ('libdir'))
conf.set('PROJECT_NAME', 'libfridge')
conf.set('PROJECT_VERSION', '0.0.1')
conf.set('API_VERSION', API_VERSION)

sources = files([
  'library.vala'
])

libfridge = library('libfridge-' + API_VERSION,
  sources,
  vala_header: 'libfridge.h',
  vala_vapi: 'libfridge-' + API_VERSION + '.vapi',
  vala_gir: 'Fridge-' + API_VERSION + '.gir',
  dependencies : dependencies,
  vala_args: [
    '--abi-stability'
    ],
  install: true,
  install_dir: [
    true,
    get_option('includedir') / 'libfridge-' + API_VERSION / 'libfridge',
    vapidir,
    g_ir_compiler.found()
  ]
)

if g_ir_compiler.found()
  custom_target('libfridge-typelib',
    command: [
      g_ir_compiler,
      '--shared-library', 'libfridge-@0@.so'.format (API_VERSION),
      '--output', '@OUTPUT@',
      meson.current_build_dir() / 'Fridge-' + API_VERSION + '.gir'
    ],
    output: 'Fridge-' + API_VERSION + '.typelib',
    depends: libfridge,
    install: true,
    install_dir: join_paths(get_option('libdir'), 'girepository-1.0'))
endif

pkgconfig.generate(libfridge,
  subdirs: 'libfridge-' + API_VERSION,
  version: API_VERSION,
  name: 'libfridge',
  filebase: 'libfridge-' + API_VERSION,
  requires: PKGCONFIG_DEPS,
  description: 'Simple Vala App Storage Library')

