FS = require 'fs'

_ = require 'lodash'
Q = require 'q'
walk = require 'walk'
commander = require 'commander'

validateDir = (dir, quiet=true, depth=-1, followLinks=false) ->
  invalids = []
  deferred = Q.defer()

  options =
    followLinks: followLinks

  walker = walk.walk dir, options

  walker.on 'file', (root, stat, next) ->
    if _.endsWith stat.name.toLowerCase(), '.json'
      path = root + '/' + stat.name
      try
        JSON.parse FS.readFileSync(path, "UTF-8")
        next()
      catch error
        invalids.push(
          file: path,
          error: error
        )
        (console.log "Invalid JSON in file", path,
          "is invalid:\n", error) if not quiet
        next()
    else
      next()

  walker.on 'errors', (root, stats, next) ->
    console.log "error walking", root, "\n  stats:", stats
    next()

  walker.on 'end', ->
    deferred.resolve invalids

  deferred.promise

module.exports = {
  validate : validateDir
}

