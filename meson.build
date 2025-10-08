project('libfridge', 'vala', 'c',
  version: '0.0.1',
  meson_version: '>= 1.1.0',
  default_options: [
    'warning_level=2',
    'werror=false',
  ],
)

LIBRARY_NAME = 'fridge'
GENERAL_NAME = 'Fridge'
PROJECT_DESCRIPTION = 'Simple Vala App Storage Library'
API_VERSION = '0.1'

pkgconfig = import('pkgconfig')
PKGCONFIG_DEPS = ['glib-2.0', 'gobject-2.0']

vapidir = get_option('datadir') / 'vala' / 'vapi'

add_project_arguments(['--enable-experimental'], language: 'vala')

g_ir_compiler = find_program('g-ir-compiler', required: false)

libfridge_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('json-glib-1.0', required : get_option('enable_json'))
]

subdir('src')

if get_option('enable_valadoc')
  valadoc = find_program('valadoc')
  libfridge_docs = custom_target(
    'generate-docs',
    input: sources,
    command: [
      valadoc,
      '-o', meson.current_source_dir() / 'docs',
      '--package-name=@0@'.format(meson.project_name()),
      '--package-version=@0@'.format(meson.project_version()),
      '--doclet',
      'devhelp',
      '@INPUT@',
      '--force'
    ],
    output: meson.project_name(),
    build_by_default: true
  )

  install_subdir(
    meson.current_source_dir() / 'docs' / meson.project_name(),
    install_dir: get_option('datadir') / 'devhelp' / 'books'
  )
endif
