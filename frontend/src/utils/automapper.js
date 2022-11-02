var AutoMapper = function() {
  this.profiles = {}
  this.version = '1.0.0'
}

AutoMapper.prototype.createMap = function(srcKey, destKey) {
  var that = this,
    combineKey = srcKey + '->' + destKey
  if (!that.profiles.hasOwnProperty(combineKey)) that.profiles[combineKey] = {}

  var funcs = {
    forMember: function(prop, any) {
      that.profiles[combineKey][prop] = any
      return funcs
    }
  }
  return funcs
}

AutoMapper.prototype.map = function(srcKey, destKey, srcObj, destObj) {
  var that = this,
    combineKey = srcKey + '->' + destKey
  if (!that.profiles.hasOwnProperty(combineKey))
    throw 'Could not find mapping with a source of ' + srcKey + ' and a destination of ' + destKey

  var profile = that.profiles[combineKey]
  for (var prop in destObj) {
    if (!profile.hasOwnProperty(prop)) destObj[prop] = srcObj.hasOwnProperty(prop) ? srcObj[prop] : destObj[prop]
    else {
      var output = profile[prop]
      if (typeof output === 'function') destObj[prop] = output(srcObj, destObj)
      else destObj[prop] = output
    }
  }
}

let automapper = new AutoMapper()

export {
    automapper
}