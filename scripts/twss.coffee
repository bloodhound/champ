# Description:
#   Hubot will respond to (in)appropriate lines with "That's what she said!"
#
# Dependencies:
#   "twss": "0.1.5"
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   Alex Mingoia

twss = require 'twss'

twss.threshold = 0.9

module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    robot.brain.twssThreshold ?= 0.9
    twss.threshold = robot.brain.twssThreshold

  robot.hear /.+/i, (msg) ->
    if twss.is(msg.match[0])
      msg.send "That's what she said!"

  robot.hear /.*twss threshold (.+)/i, (msg) ->
    if msg.match[1]
      twss.threshold = msg.match[1]
      msg.send "New TWSS threshold is " + msg.match[1]
