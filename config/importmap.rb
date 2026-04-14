# Pin npm packages by running ./bin/importmap

pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from File.expand_path('../app/javascript/controllers', __dir__), under: 'controllers'

pin 'bootstrap', to: 'common/plugins/bootstrap.min.js'
pin '@popperjs/core', to: 'common/plugins/popper.min.js'
pin 'adminlte', to: 'common/plugins/adminlte.min.js'
pin 'fontawesome', to: 'common/plugins/fontawesome/fontawesome.min.js'
pin 'fontawesome_solid', to: 'common/plugins/fontawesome/fontawesome_solid.min.js'
