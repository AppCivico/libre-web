
/**
 * BrazilianCurrency helper
 * Format a number using brazilian currency
 */

(function() {
  this.Currency = function(value) {
    return {
      amount: value,
      format: function(options) {
        var amount, cents, formated, i, j, len, numbers, reals, salts;
        this.options = options != null ? options : {};
        amount = (this.amount / 100).toFixed(2);
        reals = amount.split(/\./)[0];
        cents = amount.split(/\./)[1];
        formated = [];
        salts = 0;
        numbers = reals.split('').reverse();
        for (j = 0, len = numbers.length; j < len; j++) {
          i = numbers[j];
          formated.push(i);
          if (salts === 2) {
            if (i !== (reals.length + 1)) {
              formated.push(".");
            }
            salts = 0;
            continue;
          }
          salts++;
        }
        formated = formated.reverse();
        if (formated[0] === '.') {
          formated.shift();
        }
        formated = (formated.join('')) + "," + cents;
        if (this.options && this.options.symbol === true) {
          return "R$ " + formated;
        }
        return "" + formated;
      }
    };
  };

}).call(this);
