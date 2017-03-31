(function() {
  var e;

  try {
    this.Params = {

      /*
        class attributes
       */
      _form: null,
      _fields: {},

      /*
       class methods
       */
      form: function(obj) {
        if (obj == null) {
          obj = null;
        }
        if ((obj != null) && typeof obj === 'string') {
          this._form = document.querySelector(obj) || null;
        }
        if ((obj != null) && typeof obj === 'object') {
          this._form = obj || null;
        }
        return this;
      },
      permit: function(fields) {
        var f, i, len;
        if (this._form) {
          for (i = 0, len = fields.length; i < len; i++) {
            f = fields[i];
            this._fields[f] = this._form.elements[f];
          }
        }
        return this;
      },
      to_h: function() {
        var $input, fields, key, ref;
        fields = {};
        if (this._fields) {
          ref = this._fields;
          for (key in ref) {
            $input = ref[key];
            fields[key] = $input.value || "";
          }
        }
        return fields;
      },
      to_data: function() {
        var $input, fdata, key, ref;
        fdata = new FormData();
        if (this._fields) {
          ref = this._fields;
          for (key in ref) {
            $input = ref[key];
            if (($input != null) && $input.type === 'file') {
              if ($input.files[0]) {
                fdata.append(key, $input.files[0]);
              }
            } else if ($input != null) {
              fdata.append(key, $input.value);
            }
          }
        }
        return fdata;
      },
      to_s: function() {
        var buffer, name, params, value, value_encoded;
        buffer = [];
        params = this.to_h();
        for (name in params) {
          value = params[name];
          value_encoded = encodeURIComponent(value || "");
          if (name != null) {
            buffer.push((encodeURIComponent(name)) + "=" + value_encoded);
          }
        }
        return buffer.join("&").replace(/%20/g, "+");
      }
    };
  } catch (error) {
    e = error;
    console.error(e.message);
  }

}).call(this);
