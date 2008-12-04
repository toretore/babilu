(function(){

  var interpolatePattern = /\{\{([^}]+)\}\}/g;

  //Replace {{foo} with obj.foo
  function interpolate(str, obj){
    return str.replace(interpolatePattern, function(){
      return obj[arguments[1]] || arguments[0];
    });
  };

  function pluralize(value, count){
    return count == 1 ? value[0] : value[1];
  };

  //Split "foo.bar" to ["foo", "bar"] if key is a string
  function keyToArray(key){
    if (!key) return [];
    if (typeof key != "string") return key;
    return key.split('.');
  };

  function scope(){
    return I18n.locale || I18n.defaultLocale;
  };

  //Works mostly the same as the Ruby equivalent
  I18n.translate = function(key, opts){
    if (typeof key != "string") { //Bulk lookup
      var a = [], i;
      for (i=0; i<key.length; i++) {
        a.push(this.translate(key[i], opts));
      }
      return a;
    } else {
      opts = opts || {};
      opts.default = opts.default || null;
      key = keyToArray(opts.scope).concat(keyToArray(key));
      var value = this.lookup(key, opts.default);
      if (typeof value != "string" && value && value.length) value = pluralize(value, opts.count);
      if (typeof value == "string") value = interpolate(value, opts);
      return value;
    }
  };

  I18n.t = I18n.translate;

  I18n.lookup = function(keys, defaults){
    var key, i, value = this.translations[scope()];
    defaults = typeof defaults == "string" ? [defaults] : (defaults || []);
    while (key = keys.shift()) {
      value = value && value[key];
    }
    if (value){
      return value;
    } else {
      if (defaults.length == 0) {
        return null;
      } else if (defaults[0].substr(0,1) == ':') {
        return this.lookup([defaults[0].substr(1)], defaults.slice(1));
      } else {
        return defaults[0];
      }
    }
  };

})();
