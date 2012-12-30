# Champ

Bloodhound's happy helper. A HipChat bot powered by hubot.

## Playing with Champ

Champ is trained to respond to specific commands. You can talk to Champ by @
mentioning them or sending him a 1-to-1 message.

To see a list of commands, just ask ```champ``` for help:

    @champ help

### Available commands:

```<user> doesn't have <role> role``` Removes a role from a user  
```<user> has <role> role``` Assigns a role to a user  
```cast <card name>``` a picture of the named magic card  
```deploy <staging|production>``` deploy to staging or production  
```help``` Displays all of the help commands that champ knows about.  
```help <query>``` Displays all help commands that match <query>.  
```run <API|all|browser|iOS> tests on <dev|staging>``` run the tests  
```url encode|decode <query>``` URL encode or decode <string>  
```url form encode|decode <query>``` URL form-data encode or decode <string>  
```what role does <user> have``` Find out what roles are assigned to a specific user  
```who has admin role``` Find out who's an admin and can assign roles  

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

    HUBOT_HIPCHAT_JID="***@chat.hipchat.com/bot"
    HUBOT_HIPCHAT_PASSWORD="***"
    HUBOT_PCHAT_ROOMS="***@conf.hipchat.com"
    HUBOT_DEV_SERVER="dev.domain.com"
    HUBOT_STAGING_SERVER="staging.domain.com"
    HUBOT_DEPLOY_USERNAME="***"
    HUBOT_DEPLOY_PASSWORD="***"
