(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  App.Resource = App.Resource || {};

  App.Resource.PlanAction = (function(superClass) {
    extend(PlanAction, superClass);

    function PlanAction() {
      return PlanAction.__super__.constructor.apply(this, arguments);
    }

    PlanAction.base_api = App.config.API_BASE + "/plan";

    PlanAction.show_error = function(json) {
      var msg, token;
      token = json.error || "";
      msg = (function() {
        switch (false) {
          case !token.match(/plan '\d+' not found/):
            return 'Este item não foi encontrado. Talvez ele ja tenha sido removido.';
          case !token.match(/action_plan not found./):
            return 'Não foi possível carregar os dados da ação deste plano.';
          default:
            return '[PlanAction] Erro genérico do servidor';
        }
      })();
      return message('Erro', msg);
    };

    PlanAction.show_validations = function(form, json) {
      var $form, $input, error_message, field, key, results;
      $form = form;
      error_message = function(token) {
        var list;
        list = {
          missing: 'Campo obrigatório',
          invalid: 'Valor inválido',
          empty_is_invalid: 'Não pode ser vazio',
          repeated: 'Este item já encontra-se cadastrado'
        };
        return list[token];
      };
      $form.querySelectorAll('.error-message').map(function(x) {
        return x.parentElement.removeChild(x);
      });
      if (json.form_error != null) {
        results = [];
        for (key in list) {
          field = list[key];
          $input = $form.querySelector("input[name=" + key + "]");
          $input.parent().classList.add('has-error');
          results.push($input.after("<small class='error-message'>" + (error_message(field)) + "</small>"));
        }
        return results;
      }
    };

    PlanAction.state_id_by_name = function(state) {
      switch (state) {
        case "Em Ação":
          return 1;
        case "Atrasada":
          return 2;
        case "Finalizada":
          return 3;
      }
    };

    PlanAction.updateItem = function(plan, action) {
      action = this.put({
        endpoint: "/" + plan.id + "/action/" + action.id,
        params: action
      });
      return action = $.ajax({
        url: '',
        method: 'PUT',
        params: action
      });
    };

    PlanAction.removeItem = function(plan, id) {
      var action;
      action = this.remove({
        endpoint: "/" + plan.id + "/action/" + id
      });
      return action.fail((function(_this) {
        return function(res) {
          return _this.show_error(res.responseJSON);
        };
      })(this));
    };

    PlanAction.stateItem = function(plan, action, state) {
      var state_id;
      state_id = this.state_id_by_name(state);
      action = this.put({
        endpoint: "/" + plan.id + "/action/" + action,
        params: {
          action_plan_status_id: state_id
        }
      });
      return action.fail((function(_this) {
        return function(res) {
          return _this.show_error(res.responseJSON);
        };
      })(this));
    };

    return PlanAction;

  })(App.Resource.Base);

}).call(this);
