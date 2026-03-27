# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers", preload: false
pin "marked", preload: false # @17.0.3
pin "dompurify", preload: false # @3.3.1
pin "toastr", preload: false # @2.1.4
pin "jquery", preload: false # @3.7.1
pin "react", preload: false # @19.2.4
pin "react-dom", preload: false # @19.2.4
pin "react-dom/client", to: "react-dom--client.js", preload: false # @19.2.4
pin "scheduler", preload: false # @0.27.0
pin "boring-avatars", preload: false # @2.0.4
pin "react/jsx-runtime", to: "react--jsx-runtime.js", preload: false # @19.2.4
pin_all_from "app/javascript/components", under: "components", to: "components", preload: false
pin_all_from "app/javascript/stream_actions", under: "stream_actions", preload: false
