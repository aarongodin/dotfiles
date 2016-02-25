
var fs = require('fs')

var dotfiles = [
  '.vimrc',
  '.tmux.conf',
  '.bash_profile'
]

dotfiles.forEach(function (file) {
  var src = process.cwd() + "/" + file
  var dest = process.env.HOME + "/" + file

  fs.link(src, dest, function (err) {
    if (err) {
      if (err.errno === -17) {
        return console.log("Already exists " + file)
      }

      return console.error("Failed to link" + file, err.message)
    } else {
      return console.log("Linked " + file)
    }
  })
})

