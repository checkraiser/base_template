(function() {
  this.app = angular.module('app', ['ng-rails-csrf', 'ngStorage']);

}).call(this);
// the below is needed because of an odd issue in Google Chrome
// which causes FontAwesome icons to render as squares at times
// to use this, if you want a lightbulb icon: .fa.fa-lightbulb-o
// but it shows as a square
// write it as .fa.fa-lightbulb-o-temp.fa-temp instead
// the below code will loop through all fa-temp elements
// and change it to .fa.fa-lightbulb-o-temp.fa-temp.fa-lightbulb
// this solves the Google Chrome issue
$(document).ready(function() {
    $(".fa-temp").each(function() {
        var classnames = $(this).attr("class").split(/\s+/)
        for(var i = 0; i < classnames.length; i++) {
            var classname = classnames[i]
            if(classname == "fa-temp") {
                continue
            }
            if(classname.indexOf("fa-") == 0) {
                var new_classname = classname.substr(0, classname.length - "-temp".length)
                $(this).addClass(new_classname)
            }
        }
    })
})
;
(function() {
  window.ListenerList = (function() {
    ListenerList.listeners = [];

    function ListenerList() {
      this.listeners = [];
    }

    ListenerList.prototype.add_listener = function(listener) {
      return this.listeners.push(listener);
    };

    ListenerList.prototype.notify = function(item) {
      var i, len, listener, ref, results;
      ref = this.listeners;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        listener = ref[i];
        results.push(listener(item));
      }
      return results;
    };

    return ListenerList;

  })();

}).call(this);
(function() {
  app.factory('Api', [
    '$http', '$timeout', 'ApiFeedback', function($http, $timeout, ApiFeedback) {
      var api;
      api = {};
      api.post = function(url, options) {
        return api.perform_request($http.post, url, options);
      };
      api.put = function(url, options) {
        return api.perform_request($http.put, url, options);
      };
      api.get = function(url, options) {
        return api.perform_request($http.get, url, options);
      };
      api["delete"] = function(url, options) {
        return api.perform_request($http["delete"], url, options);
      };
      api.process_request = function(http_function, url, data, options, success, error, on_response) {
        if (data == null) {
          data = {};
        }
        return http_function(url, data).success(function(response) {
          if (options.before_success) {
            options.before_success(response);
          }
          if (success) {
            success(response);
          }
          if (options.after_success) {
            options.after_success(response);
          }
          if (on_response) {
            on_response(response);
          }
          if (options.after_response) {
            return options.after_response(response);
          }
        }).error(function(response) {
          if (error) {
            error(response);
          }
          if (on_response) {
            on_response(response);
          }
          if (options.after_response) {
            return options.after_response(response);
          }
        });
      };
      api.perform_request = function(http_function, url, options) {
        var button, data, disable_button, error, error_key_replacements, on_response, render_modal_errors, success, success_message, success_message_delay;
        ApiFeedback.clear_errors();
        if (options == null) {
          options = {};
        }
        data = options.data || {};
        button = null;
        if (options.button && (typeof options.button.button === "function")) {
          button = options.button;
        }
        success_message = options.success_message;
        success_message_delay = options.success_message_delay || 2000;
        success = options.success;
        error = options.error;
        on_response = options.on_response;
        error_key_replacements = options.error_key_replacements;
        disable_button = options.disable_button;
        render_modal_errors = options.render_modal_errors;
        if (button !== null) {
          button.button("loading");
        }
        return api.process_request(http_function, url, data, options, function(response) {
          if (success) {
            success(response);
          }
          if (success_message) {
            return ApiFeedback.show_success_message(success_message, success_message_delay);
          }
        }, function(response) {
          if (error) {
            error(response);
          }
          return ApiFeedback.render_errors(response, error_key_replacements, render_modal_errors);
        }, function(response) {
          if (on_response) {
            on_response(response);
          }
          if (button !== null) {
            button.button("reset");
            if (disable_button) {
              return $timeout(function() {
                return button.attr('disabled', 'disabled');
              });
            }
          }
        });
      };
      return api;
    }
  ]);

}).call(this);
(function() {
  app.factory('ApiFeedback', [
    '$timeout', function($timeout) {
      var api_feedback, parse_errors;
      api_feedback = {
        success_messages: []
      };
      api_feedback.clear_errors = function() {
        api_feedback.error_message = "";
        api_feedback.errors = [];
        api_feedback.modal_error_message = "";
        return api_feedback.modal_errors = [];
      };
      api_feedback.show_success_message = function(message, delay) {
        if (message == null) {
          message = "Success!";
        }
        if (delay == null) {
          delay = 2000;
        }
        api_feedback.success_messages.push(message);
        return $timeout(function() {
          return api_feedback.success_messages.splice(0, 1);
        }, delay);
      };
      parse_errors = function(data_errors, error_key_replacements) {
        var error_detail, error_detail_arr, error_key, error_str, errors, i, len;
        if (is_empty(data_errors)) {
          return;
        }
        errors = [];
        for (error_key in data_errors) {
          error_detail_arr = data_errors[error_key];
          for (i = 0, len = error_detail_arr.length; i < len; i++) {
            error_detail = error_detail_arr[i];
            if (!is_empty(error_key_replacements) && !is_empty(error_key_replacements[error_key])) {
              error_key = error_key_replacements[error_key];
            }
            error_str = error_key.humanize() + " " + error_detail;
            if (error_detail.starts_with("You ")) {
              error_str = error_detail;
            }
            errors.push(error_str);
          }
        }
        return errors;
      };
      api_feedback.render_errors = function(data, error_key_replacements, render_modal_errors) {
        if (data == null) {
          data = {};
        }
        if (render_modal_errors) {
          api_feedback.modal_error_message = data.message;
          api_feedback.modal_errors = parse_errors(data.errors, error_key_replacements);
          $timeout(function() {
            return $(".modal.in").first().scrollTop(0);
          });
          return;
        }
        api_feedback.error_message = data.message;
        api_feedback.errors = parse_errors(data.errors, error_key_replacements);
        return $timeout(function() {
          return scroll_to_element($(".alert-danger").first());
        });
      };
      return api_feedback;
    }
  ]);

}).call(this);
(function() {
  app.factory('Browser', [
    function() {
      var self;
      self = {};
      self.init_key = function(target_key) {
        if (is_empty(localStorage.getItem(target_key)) || isNaN(localStorage.getItem(target_key))) {
          return localStorage.setItem(target_key, 0);
        }
      };
      self.on = function(target_key, listener) {
        self.init_key(target_key);
        return $(window).bind('storage', function(e) {
          if (e.originalEvent.key === target_key) {
            return listener();
          }
        });
      };
      self.notify = function(target_key) {
        var target_key_value;
        self.init_key(target_key);
        target_key_value = parseInt(localStorage.getItem(target_key));
        return localStorage.setItem(target_key, target_key_value + 1);
      };
      return self;
    }
  ]);

}).call(this);
(function() {
  app.factory('EventSystem', [
    'Api', function(Api) {
      var self;
      self = {
        user_socket: null,
        message_created_listeners: new ListenerList(),
        contacts_loaded_listeners: new ListenerList()
      };
      self.init = function() {
        var url;
        url = window.location.hostname;
        self.user_socket = io.connect(url + ':5002');
        console.log(url);
        self.user_socket.on("message-created", function(data) {
          console.log(data);
          return self.message_created_listeners.notify(data);
        });
        return self.user_socket.on("contacts-loaded", function(data) {
          console.log(data);
          return self.contacts_loaded_listeners.notify(data);
        });
      };
      return self;
    }
  ]);

}).call(this);
(function() {
  app.controller('application_controller', [
    '$scope', '$localStorage', '$sessionStorage', function($scope, $localStorage, $sessionStorage) {
      $scope.app_user = gon.app_user;
      $scope.localStorage = $localStorage;
      return $scope.sessionStorage = $sessionStorage;
    }
  ]);

}).call(this);
(function() {
  app.controller('clients_manage_controller', ['$scope', function($scope) {}]);

}).call(this);
(function() {
  app.controller('contacts_manage_controller', ['$scope', function($scope) {}]);

}).call(this);
(function() {
  app.controller('header_controller', ['$scope', function($scope) {}]);

}).call(this);
(function() {
  app.controller('home_demo_controller', [
    '$scope', 'EventSystem', function($scope, EventSystem) {
      $scope.messages = [];
      $scope.contacts = [];
      EventSystem.message_created_listeners.add_listener(function(data) {
        return $scope.$apply($scope.messages.push(data.data));
      });
      EventSystem.contacts_loaded_listeners.add_listener(function(data) {
        return $scope.$apply($scope.contacts.push(data.data));
      });
      return EventSystem.init();
    }
  ]);

}).call(this);
(function() {
  app.controller('home_index_controller', ['$scope', function($scope) {}]);

}).call(this);
(function() {
  app.controller('users_after_login_controller', [
    '$scope', function($scope) {
      var next_url;
      next_url = gon.after_initialization_url || "/";
      if (next_url.indexOf("users/after_login") > 0) {
        next_url = "/";
      }
      return window.location = next_url;
    }
  ]);

}).call(this);
(function() {
  app.controller('users_manage_controller', ['$scope', function($scope) {}]);

}).call(this);
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//




