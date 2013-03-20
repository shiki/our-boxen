
class fufulabs {
  include java
  include wget

  include dropbox
  include firefox
  include cyberduck
  include appcleaner
  include chrome
  include chrome::canary
  include slate
  include fluid
  include virtualbox
  include iterm2::stable
  include macvim
  include sublime_text_2
  include keepassx

  #include alfred
  #include transmission
  #include handbrake

  package { 'SourceTree':
    provider => 'appdmg',
    source => 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.5.8.dmg'
  }

  package { 'Skype_FuFu':
    provider => 'appdmg',
    source => 'http://download.skype.com/macosx/Skype_6.3.59.582.dmg'
  }
}
