_ = require 'lodash'
Q = require 'q'
FS = require 'fs'
assert = require 'assert'

validator = require '../src/index'

describe "validator", ->
  it "should parse all json files", (done) ->
    try
      validator.validate 'test'
      .then (invalids) -> 
        assert.equal invalids.length, 1
        invalids
      .then (invalids) ->
        assert.equal true, _.endsWith(invalids[0].file, 'bad.json')
      .then -> done()
      .catch (error) ->
        console.log "error:", error, "\nstack:\n", error.stack
        done error
    catch error
      done error
