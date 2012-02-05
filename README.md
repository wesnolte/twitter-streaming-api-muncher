Description
===========

The TBITW daemon is used to track twitter keyword list. 
To run this on a local machine:
 -> Setup the mongodb database on your machine
 -> Run the following command:
     > ruby tbitwdaemon

TODO
----
1. Create the junction mongodb collection to store the tweet list.

Tweetstream Daemon on Heroku
============================

Sample app for using Tweetstream daemon on heroku.

Deploying
---------

    $ heroku create
    $ heroku config:add TWITTER_USERNAME=foo TWITTER_PASSWORD=password
    $ heroku workers 1
