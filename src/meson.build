tracky_sources = [
  'app.vala',
  'config.vala',
  'helper.vala',
  'database.vala',
  'models/task.vala',
  'models/taskgoal.vala',
  'models/mainmodel.vala',
  'views/widgets/taskwidget.vala',
  'views/widgets/taskgoalwidget.vala',
  'views/window.vala'
]

tracky_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('sqlite3', version: '>= 3.26'),
  dependency('gee-0.8', version: '>= 0.20'),
  dependency('libnotify', version: '>= 0.7')
]

gnome = import('gnome')

tracky_sources += gnome.compile_resources('tracky-resources',
  'tracky.gresource.xml',
  c_name: 'tracky'
)

executable('tracky', tracky_sources,
  vala_args: '--target-glib=2.50',  dependencies: tracky_deps,
  install: true
)
