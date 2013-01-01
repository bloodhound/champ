# Description:
#   Fill your chat with some kindness
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot be nice - just gives some love :)
#
# Author:
#   nesQuick

hugs = [
  "/me wags tail",
  "Woof! =)",
  "Everyone smiles in the same language. Woof!"
]

module.exports = (robot)->
  robot.respond /be nice/i, (message)->
    rnd = Math.floor Math.random() * hugs.length
    message.send hugs[rnd]
