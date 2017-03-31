(function() {
  var e;

  try {
    this.MaskHelper = VMasker;
    this.MaskHelper.register_masks = function($parent) {
      var $list, options;
      $list = $parent.find('*[data-mask=number]');
      if ($list.length > 0) {
        $list.map(function(i, el) {
          return VMasker(el).maskNumber();
        });
      }
      $list = $parent.find('*[data-mask=money]');
      if ($list.length > 0) {
        options = {
          precision: 2,
          separator: ',',
          delimiter: '.',
          unit: 'R$',
          suffixUnit: '',
          zeroCents: true
        };
        $list.map(function(i, el) {
          return VMasker(el).maskMoney(options);
        });
      }
      $list = $parent.find('[data-mask=date]');
      if ($list.length > 0) {
        $list.map(function(i, el) {
          return VMasker(el).maskPattern("99/99/9999");
        });
      }
      $list = $parent.find('[data-mask=cpf]');
      if ($list.length > 0) {
        $list.map(function(i, el) {
          return VMasker(el).maskPattern("999.999.999-99");
        });
      }
      $list = $parent.find('[data-mask=cnpj]');
      if ($list.length > 0) {
        $list.map(function(i, el) {
          return VMasker(el).maskPattern("99.999.999/9999-99");
        });
      }
      $list = $parent.find('[data-mask=phone]');
      if ($list.length > 0) {
        $list.map(function(i, el) {
          return VMasker(el).maskPattern("(99) 999999999");
        });
      }
      $list = $parent.find('[data-mask=number]');
      if ($list.length > 0) {
        return $list.map(function(i, el) {
          return VMasker(el).maskNumber();
        });
      }
    };
  } catch (error) {
    e = error;
    console.error(e.message);
  }

}).call(this);
