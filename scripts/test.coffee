# Description:
#   Run tests and report the results.
#
# Dependencies:
#   "ssh2": "0.1.x"
#
# Configuration:
#   None
#
# Commands:
#   hubot run <API|all|browser|iOS> tests on <dev|staging> - run the tests
#
# Author:
#   None

SSH = require 'ssh2'

module.exports = (robot) ->
  robot.respond /.*test.*/i, (msg) ->
    suiteMatch = msg.match[0].match /.*(API|all|browser|iOS).*/i
    envMatch = msg.match[0].match /.*(dev|staging).*/i
    suite = 'all'
    env = 'staging'
    if suiteMatch and suiteMatch[1]
      suite = suiteMatch[1]
    if envMatch and envMatch[1]
      env = envMatch[1]
    ssh = new SSH
    ssh.on 'ready', ->
      ssh.shell (err, stream) ->
        if err
          throw err
        stream.setEncoding 'utf8'
        cmd = 'echo "' + process.env.HUBOT_DEPLOY_PASSWORD + '" | ' +
              'sudo -iS bh-tests --test-suite ' + suite + "\n"
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
    host = process.env.HUBOT_STAGING_SERVER
    if env == 'dev'
      host = process.env.HUBOT_DEV_SERVER
    ssh.connect
      host: host
      port: 22
      username: process.env.HUBOT_DEPLOY_USERNAME
      password: process.env.HUBOT_DEPLOY_PASSWORD
      tryKeyboard: true
    msg.send "Woof! Running " + suite + " tests on " + env + "!"
