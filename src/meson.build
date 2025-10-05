sources = files([
  'library.vala'
])

libfridge = library(
  LIBRARY_NAME + '-' + API_VERSION,
  sources,
  vala_header: meson.project_name() + '.h',
  vala_vapi: meson.project_name() + '-' + API_VERSION + '.vapi',
  vala_gir: GENERAL_NAME + '-' + API_VERSION + '.gir',
  soversion: API_VERSION,
  dependencies : libfridge_deps,
  vala_args: [
    '--abi-stability'
    ],
  install: true,
  install_dir: [
    true,
    get_option('includedir') / meson.project_name() + '-' + API_VERSION / meson.project_name(),
    vapidir,
    g_ir_compiler.found()
  ]
)

libfridge_dep = declare_dependency(
  link_with: libfridge,
  include_directories: '.',
  dependencies: libfridge_deps
)

if g_ir_compiler.found()
  custom_target(
    meson.project_name() + '-typelib',
    command: [
      g_ir_compiler,
      '--shared-library', meson.project_name() + '-@0@.so'.format (API_VERSION),
      '--output', '@OUTPUT@',
      meson.current_build_dir() / GENERAL_NAME + '-' + API_VERSION + '.gir'
    ],
    output: GENERAL_NAME + '-' + API_VERSION + '.typelib',
    depends: libfridge,
    install: true,
    install_dir: join_paths(get_option('libdir'), 'girepository-1.0')
  )
endif

pkgconfig.generate(
  libfridge,
  version: API_VERSION,
  name: meson.project_name(),
  filebase: meson.project_name() + '-' + API_VERSION,
  subdirs: meson.project_name() + '-' + API_VERSION,
  requires: PKGCONFIG_DEPS,
  description: PROJECT_DESCRIPTION
)
