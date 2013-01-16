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
#   hubot run <API|all|browser|iOS> tests - Run the tests on staging
#   hubot are tests running? - See if the tests are currently running
#   hubot stop the tests - Stop the tests if they are running
#
# Author:
#   None

SSH = require 'ssh2'

module.exports = (robot) ->
  ssh = {_state: 'closed'}

  robot.respond /.*are.+tests running/i, (msg) ->
    if ssh._state != 'closed'
      msg.send "Yup the tests are currently running. Woof!"
    else
      msg.send "Nope, the tests aren't running. Woof!"

  robot.respond /.*stop.*tests/i, (msg) ->
    if ssh._state != 'closed'
      ssh.end()
      msg.send "Woof! Tests stopped!"
    else
      msg.send "Tests aren't running!"

  robot.respond /.*(run|start).+test.*/i, (msg) ->
    if !robot.Auth.hasRole(msg.message.user.name, 'engineer')
      msg.send "Woof! I'm not listening to you! You're not an engineer."
      return null
    if ssh._state != 'closed'
      msg.send "The tests are currently running! Woof!"
      return null

    ssh = new SSH

    ssh.on 'error', (err) ->
      console.log err

    ssh.on 'keyboard-interactive', (n, i, iL, prompts, finish) ->
      prompts.filter (prompt) ->
        if prompt.prompt == 'Password:'
          finish [process.env.HUBOT_DEPLOY_PASSWORD]

    suiteMatch = msg.match[0].match /.*(API|all|browser|iOS).*/i
    suite = 'all'
    if suiteMatch and suiteMatch[1]
      suite = suiteMatch[1]
    ssh.once 'ready', ->
      ssh.shell (err, stream) ->
        if err
          throw err
        stream.setEncoding 'utf8'
        cmd = 'echo "' + process.env.HUBOT_DEPLOY_PASSWORD + '" | ' +
              'sudo -iS bh-tests --test-suite ' + suite + "\n"
        sent = false
        stream.on 'data', (data) ->
          if data.match /Tests are already running/
            msg.send "Tests are already running. Woof!"
            ssh.end()
          if data.match /:\~\$/
            if sent
              ssh.end()
            else
              sent = true
              response = "Woof! Running " + suite + " tests on " +
                           process.env.HUBOT_STAGING_SERVER + "!"
              msg.send response
              stream.write cmd, 'utf8'
    ssh.connect
      host: process.env.HUBOT_STAGING_SERVER
      port: 22
      username: process.env.HUBOT_DEPLOY_USERNAME
      password: process.env.HUBOT_DEPLOY_PASSWORD
      tryKeyboard: true
