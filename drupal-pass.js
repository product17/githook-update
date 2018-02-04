var drupalHash = require('drupal-hash');

var pass = drupalHash.hashPassword('testtest');

console.log(pass);
