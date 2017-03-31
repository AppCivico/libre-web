(function() {
  if (App.Controller == null) {
    App.Controller = {};
  }


  /*
    Controller Base class
   */

  App.Controller.Base = (function() {
    Base.prototype.link_list = [
      {
        id: 1,
        link: '/app',
        label: 'meu painel'
      }, {
        id: 2,
        link: '/app/autoavaliacao',
        label: 'autoavaliação',
        need_plan: false
      }, {
        id: 3,
        link: '/app/autoavaliacao/resultado',
        label: 'resultado da avaliação'
      }, {
        id: 4,
        link: '/app/plano-de-acao',
        label: 'plano de ação'
      }, {
        id: 5,
        link: '/app/dados-de-consumo',
        label: 'dados de consumo'
      }
    ];

    function Base(options1) {
      this.options = options1 != null ? options1 : {};
      this._showAdminMenu(this.options);
      this.init(this.options);
      this.bind(this.options);
    }

    Base.prototype.check_authentication = function(options) {
      var l;
      if (options == null) {
        options = {};
      }
      this.current_user = session().get('user') || {};
      if (!(this.current_user && (this.current_user["id"] != null) && (this.current_user["apikey"] != null))) {
        l = URI.relative();
        redirect_to("/?error=session_timeout&location=" + l);
      }
      return this.current_user;
    };

    Base.prototype.current_user = function(options) {
      if (options == null) {
        options = {};
      }
      return session().get('user') || {};
    };

    Base.prototype.signout = function(options) {
      if (options == null) {
        options = {};
      }
      session().clear();
      return redirect_to(options["url"] || '/');
    };

    Base.prototype.qs = function(selector, scope) {
      if (selector == null) {
        selector = null;
      }
      if (scope == null) {
        scope = document;
      }
      return scope.querySelector(selector);
    };

    Base.prototype.qsa = function(selector, scope) {
      if (selector == null) {
        selector = null;
      }
      if (scope == null) {
        scope = document;
      }
      return scope.querySelectorAll(selector);
    };

    Base.prototype.params = function(selector) {
      return Params.form(selector);
    };

    Base.prototype.session = function(key, value) {
      if (key == null) {
        key = null;
      }
      if (value == null) {
        value = null;
      }
      if ((key != null) && (value == null)) {
        return session().get(key);
      }
      if ((key != null) && (value != null)) {
        return session().set(key, value);
      }
      return session();
    };

    Base.prototype.template = function(selector) {
      var template;
      template = document.getElementById(selector);
      return {
        _template: template,
        hasTemplate: function() {
          if (this._template != null) {
            return true;
          } else {
            return false;
          }
        },
        render: function(stash, same_origin) {
          var rendered;
          if (stash == null) {
            stash = {};
          }
          if (same_origin == null) {
            same_origin = true;
          }
          rendered = $.templates(this._template).render(stash);
          if (same_origin) {
            this._template.insertAdjacentHTML('beforebegin', rendered);
          }
          return rendered;
        }
      };
    };

    Base.prototype._showAdminMenu = function(options1) {
      var $menu, ctrl, i, l, len, ref, ref1, ref2, template, user;
      this.options = options1;
      ctrl = this.options.controller || null;
      user = this.current_user();
      if ($menu = document.getElementById('dashboard-menu')) {
        template = '';
        ref = this.link_list;
        for (i = 0, len = ref.length; i < len; i++) {
          l = ref[i];
          if (user.has_current_plan) {
            if ((ref1 = l.id) === 1 || ref1 === 3 || ref1 === 4 || ref1 === 5) {
              template += "<a href=\"" + l.link + "\">" + l.label + "</a>";
            }
          } else {
            if ((ref2 = l.id) === 1 || ref2 === 2) {
              template += "<a href=\"" + l.link + "\">" + l.label + "</a>";
            }
          }
        }
        return $menu.innerHTML = template;
      }
    };

    return Base;

  })();

}).call(this);
