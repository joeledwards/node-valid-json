# node-valid-json
Recursively validate format of all JSON files in a directory.

### Acquire a list of all JSON files which are not formatted correctly
```coffeescript
dir = 'json/schemas'
validator = require 'valid-json' 
validator.validate dir
  .then (invalids) -> console.log(invalids.length, "invalid json files")
  .catch (error) -> "error traversing schemas directory:", error, "\nstack:\n", error.stack
```

