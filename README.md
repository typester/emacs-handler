EmacsURLHandler for OSX
=======================

This application enables your emacs to open files via hyperlinks starts with `emacs://` something like:

    emacs://open/?url=file:///etc/passwd&line=10&column=2

This URL format is same as TextMate's `txmt:` scheme described [here](http://manual.macromates.com/en/using_textmate_from_terminal#url_scheme_html)

Requirements
------------

* Mac OS X (10.5 or 10.6)
* Emacs

Download
--------

[EmacsHandler-1.0.zip](http://cloud.github.com/downloads/typester/emacs-handler/EmacsHandler-1.0.zip) (Universal Binary)

Installation
------------

Download [latest release](http://cloud.github.com/downloads/typester/emacs-handler/EmacsHandler-1.0.zip).

Unzip it, and install it in your Applications directory.

Launch it and select `EmacsHandler` -> `Preferences...`, then following window will open.

<a href="http://www.flickr.com/photos/typester/4060516152/" title="EmacsHandler Preferences by typester, on Flickr"><img src="http://farm3.static.flickr.com/2561/4060516152_16d3370a7a_o.png" width="480" height="252" alt="EmacsHandler Preferences" /></a>

Enter your emacsclient path and push apply button.

Test it
-------

Open terminal and type:

    open 'emacs://open/?url=file:///etc/hosts'

or just click [this link](emacs://open/?url=file:///etc/hosts)


Uninstalling
------------

Delete following:

    /Applications/EmacsHandler.app
    ~/Library/Preferences/org.unknownplace.emacshandler.plist


Author
------

Daisuke Murase :@typester (github, twitter, CPAN, etc..)

License
-------

BSD.

