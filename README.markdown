# Heroku suggest

DEPRECATED: This functionality has been merged directly into the heroku gem.

Suggests commands to you when you type incorrect values in.

## Installation

    $ heroku plugins:install git://github.com/geemus/heroku-suggest.git

## Usage

After installation the plugin should work seamlessly. You can try it out by purposely mistyping some commands.

For instance, if you meant to type `domains` but left off the s you would see:

    ⌘ heroku domain
     !    'domain' is not a heroku command.
     !    Perhaps you meant 'domains'.
     !    See 'heroku help' for additional details.

Similarly, if you meant to type `apps` but left out one of the p's you would see:

    ⌘ heroku aps
     !    'aps' is not a heroku command.
     !    Perhaps you meant 'apps' or 'ps'.
     !    See 'heroku help' for additional details.
