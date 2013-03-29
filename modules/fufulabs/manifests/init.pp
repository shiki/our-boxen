
class fufulabs {
  require ruby::2_0_0
  require nodejs::0-10

  include xquartz
  include java
  include wget
  include zsh

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
  include alfred
  include caffeine
  include mou
  include flux

  package { 'SourceTree':
    provider => 'appdmg',
    source => 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.5.8.dmg'
  }

  package { 'Skype_FuFu':
    provider => 'appdmg',
    source => 'http://download.skype.com/macosx/Skype_6.3.59.582.dmg'
  }

  # https://github.com/all9lives/puppet-skitch
  package { 'Skitch':
    provider => 'compressed_app',
    source   => 'http://cdn1.evernote.com/skitch/mac/release/Skitch-2.0.5.zip'
  }

  package { 'Unarchiver': 
    provider => 'compressed_app',
    source   => 'http://theunarchiver.googlecode.com/files/TheUnarchiver3.6.1.zip'
  }

  package { 'Eggscellent': 
    provider => 'compressed_app',
    source => 'https://s3.amazonaws.com/eggscellent/betas/Eggscellent_Beta2.zip'
  }

  package { 'tree': }

  # Set default version for Ruby
  class { 'ruby::global': version => '2.0.0' }
}
