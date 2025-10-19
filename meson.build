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

if build_machine.system() == 'linux'
    vala_os_arg = ['--define=LINUX']
elif build_machine.system() == 'dragonfly'
    vala_os_arg = ['--define=DRAGON_FLY']
elif build_machine.system() == 'freebsd'
    vala_os_arg = ['--define=FREE_BSD']
elif build_machine.system() == 'netbsd'
    vala_os_arg = ['--define=NET_BSD']
elif build_machine.system() == 'windows'
    vala_os_arg = ['--define=WINDOWS']
else
    vala_os_arg = []
endif

glib_min_version = '2.50'
if build_machine.system() == 'windows'
    gio_os_dep = dependency('gio-windows-2.0', version: '>=' + glib_min_version)
else
    gio_os_dep = dependency('gio-unix-2.0', version: '>=' + glib_min_version)
endif

add_project_arguments(
    vala_os_arg,
    '--target-glib=' + glib_min_version,
    language: ['vala']
)

libfridge_deps = [
  dependency('gio-2.0', version: '>=' + glib_min_version),
  gio_os_dep,
  dependency('glib-2.0', version: '>=' + glib_min_version),
  dependency('gobject-2.0', version: '>=' + glib_min_version),
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
