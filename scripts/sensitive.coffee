# Description:
#   Hubot has feelings too, you know
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   iangreenleaf

messages = [
  "Hey, that stings.",
  "Is that tone really necessary?",
  "Dogs have feelings too, you know.",
  "You should try to be nicer.",
  "I'm sorry, I'll try to do better next time."
]

hurt_feelings = (msg) ->
  msg.send msg.random messages

module.exports = (robot) ->
  pejoratives = "bad|stupid|buggy|useless|dumb"

  r = new RegExp "\\b(you|u|is)\\b.*(#{pejoratives})", "i"
  robot.respond r, hurt_feelings

  r = new RegExp "(#{pejoratives}) (dog|#{robot.name})", "i"
  robot.hear r, hurt_feelings
