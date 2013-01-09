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

twss.threshold = 0.75

module.exports = (robot) ->
  robot.hear /.+/i, (msg) ->
    if twss.is(msg.match[0])
      msg.send "That's what she said!"
