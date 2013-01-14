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
#   hubot deploy <staging|production> - deploy to staging or production. Only users assigned the 'engineer' role may deploy.
#
# Author:
#   None

SSH = require 'ssh2'

module.exports = (robot) ->
  ssh = new SSH

  ssh.on 'error', (err) ->
    console.log err

  ssh.on 'keyboard-interactive', (n, i, iL, prompts, finish) ->
    prompts.filter (prompt) ->
      if prompt.prompt == 'Password:'
        finish [process.env.HUBOT_DEPLOY_PASSWORD]

  robot.respond /.*(deploy|push)(.+)?/i, (msg) ->
    if !robot.Auth.hasRole(msg.message.user.name, 'engineer')
      msg.send "Woof! I'm not listening to you!"
      return
    match = msg.match[2].match /.*(staging|production|live).*/i
    if env = match[1]
      if env == 'live'
        env = 'production'
      ssh.once 'ready', ->
        ssh.shell (err, stream) ->
          if err
            throw err
          stream.setEncoding 'utf8'
          cmd = 'echo "' + process.env.HUBOT_DEPLOY_PASSWORD + '" | ' +
                'sudo -iS deploy ' + env + "\n"
          sent = false;
          stream.on 'data', (data) ->
            if data.match /:\~\$/
              if sent
                ssh.end()
              else
                sent = true
                msg.send "Woof! Deploying to " + env + "!"
                stream.write cmd, 'utf8'
      ssh.connect
        host: process.env.HUBOT_STAGING_SERVER
        port: 22
        username: process.env.HUBOT_DEPLOY_USERNAME
        password: process.env.HUBOT_DEPLOY_PASSWORD
        tryKeyboard: true
