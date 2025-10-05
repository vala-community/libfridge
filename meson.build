project('libfridge', 'vala', 'c',
  version: '0.0.1',
  meson_version: '>= 1.4.0',
  default_options: [
    'warning_level=2',
    'werror=false',
  ],
)

name = meson.project_name() + '-' + version.to_string()
src_dir = join_paths(meson.project_source_root(), 'src')
is_subproject = meson.is_subproject()

API_VERSION = '0.1'

dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0')
]

pkgconfig = import('pkgconfig')

PKGCONFIG_DEPS = ['glib-2.0', 'gobject-2.0']
vapidir = get_option('datadir') / 'vala' / 'vapi'

add_project_arguments(['--enable-experimental'], language: 'vala')

g_ir_compiler = find_program('g-ir-compiler', required: false)

subdir('src')

if get_option('enable_valadoc')
  valadoc = find_program('valadoc')
  libfridge_docs = custom_target('generate-docs',
    input: sources,
    install: true,
    # FIXME: Installing to tmp, so the target will be built
    #        the problem is we cannot access a subfolder of the
    #        buildtarget via the output parameter.
    #        Find a nicer solution
    install_dir: get_option('datadir') / 'devhelp' / 'books',
    command: [
      valadoc,
      '-o', meson.current_build_dir() / 'Fridge-' + API_VERSION,
      '--doclet',
      'devhelp',
      '@INPUT@',
      '--force'
    ],
    output: 'Fridge-' + API_VERSION)

  install_subdir(meson.current_build_dir() / 'Fridge-' + API_VERSION / 'Fridge-' + API_VERSION,
    install_dir: get_option('datadir') / 'devhelp' / 'books')
endif

