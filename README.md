# Champ

Bloodhound's happy helper. A HipChat bot powered by hubot.

## Playing with Champ

Champ is trained to respond to specific commands. You can talk to Champ by @
mentioning him in a room or sending him a 1-to-1 message.

### Available commands:

To see a list of commands, just ask ```champ``` for help:

    @champ help

## Development

You'll need to install the necessary dependencies for champ. All of
those dependencies are provided by [npm][npmjs].

[npmjs]: http://npmjs.org)

[hubot](https://github.com/github/hubot)  
[hubot-hipchat](https://github.com/hipcat/hubot-hipchat)  
[hubot-scripts](https://github.com/github/hubot-scripts)  
[optparse](https://github.com/jfd/optparse-js)  
[node-stringprep (OS X)](https://github.com/astro/node-stringprep)  

The following environment variables are required when running champ:

    HUBOT_AUTH_ADMIN="User Name"
    HUBOT_HIPCHAT_JID="***@chat.hipchat.com/bot"
    HUBOT_HIPCHAT_PASSWORD="***"
    HUBOT_HIPCHAT_ROOMS="***@conf.hipchat.com"
    HUBOT_DEV_SERVER="dev.domain.com"
    HUBOT_STAGING_SERVER="staging.domain.com"
    HUBOT_DEPLOY_USERNAME="***"
    HUBOT_DEPLOY_PASSWORD="***"
    HUBOT_TWITTER_MENTION_QUERY="@bloodhound"
    HUBOT_TWITTER_MENTION_ROOM="***@conf.hipchat.com"
    FILE_BRAIN_PATH="/path/to/store/brain"
