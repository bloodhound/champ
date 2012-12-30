# Description:
#   Deploy to staging or production.
#
# Dependencies:
#   "ssh2": "0.1.x"
#
# Configuration:
#   None
#
# Commands:
#   hubot deploy <staging|production> - deploy to staging or production
#
# Author:
#   None

SSH = require 'ssh2'

module.exports = (robot) ->
  robot.respond /.*(deploy|push)(.+)?/i, (msg) ->
    match = msg.match[2].match /.*(staging|production|live).*/i
    if env = match[1]
      if env == 'live'
        env = 'production'
      if env == 'live' or env == 'production'
        return msg.send "Woof! I can't deploy to production. Sorry :("
      ssh = new SSH
      ssh.on 'ready', ->
        ssh.shell (err, stream) ->
          if err
            throw err
          stream.setEncoding 'utf8'
          cmd = 'echo "' + process.env.HUBOT_DEPLOY_PASSWORD + '" | ' +
                'sudo -iS deploy ' + env + "\n"
          sent = false
          stream.on 'data', (data) ->
            if data.match /:\~\$/
              if sent
                ssh.end
              else
                sent = true
                stream.write cmd, 'utf8'
      ssh.on 'keyboard-interactive', (n, i, iL, prompts, finish) ->
        prompts.filter (prompt) ->
          if prompt.prompt == 'Password:'
            finish [process.env.HUBOT_DEPLOY_PASSWORD]
      ssh.on 'error', (err) ->
        console.log err
      ssh.connect
        host: process.env.HUBOT_STAGING_SERVER
        port: 22
        username: process.env.HUBOT_DEPLOY_USERNAME
        password: process.env.HUBOT_DEPLOY_PASSWORD
        tryKeyboard: true
      msg.send "Woof! Deploying to " + env + "!"
