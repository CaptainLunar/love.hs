# love.hs

A terminal startup application that greets you with positive messages, inspirational quotes, and the weather.

You can add your own messages in the following .txt files:
* lovegreet.txt -> Messages used to greet the user.
* lovemsg.txt   -> Messages used to lovingly support the user. 
* myAPIkey.txt  -> You need to get an API key from the Weather Underground. They are free. 

## What you need to get it running:
* Edit whatever startup file you use, .bashrc, /etc/profile, and set it to run this functional program. For less clutter, hide the program in some hidden folder and add it to your profile file! 
* Run `cabal install` to set up program.

## You need to install the following programs for love to work:
* Fortune -> Can be installed with `sudo apt-get install fortune` 

Todo:
* ☼ Add colors to terminal.
* ☼ Implement logic structures to make user aware of what they need to wear outside due to weather conditions.

