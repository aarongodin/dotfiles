const fs = require('fs')

const dotfiles = [
  '.vimrc',
  '.tmux.conf',
  '.bash_profile',
  '.gemrc'
]

dotfiles.forEach(file => {
  const src = process.cwd() + "/" + file
  const dest = process.env.HOME + "/" + file

  fs.link(src, dest, (err) => {
    if (err) {
      if (err.errno === -17) {
        return console.log(`Already exists ${file}`)
      }

      return console.error(`Failed to link ${file}`, err.message)
    } else {
      return console.log(`Linked ${file}`)
    }
  })
})

