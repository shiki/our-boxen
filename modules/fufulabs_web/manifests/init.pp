
# Packages for web developers (PHP)

class fufulabs_web {
  require homebrew

  include nginx
  include memcached
  include redis
  include mysql
  include beanstalk

  package { 'Sequel_Pro':
    provider => 'appdmg',
    source => 'http://sequel-pro.googlecode.com/files/sequel-pro-1.0.1.dmg'
  }

  package { 'graphicsmagick': }

  exec { 'tap-homebrew-dupes':
    command => "brew tap homebrew/dupes",
    creates => "${homebrew::config::tapsdir}/homebrew-dupes",
  }

  exec { 'tap-josegonzalez-php':
    command => "brew tap josegonzalez/homebrew-php",
    creates => "${homebrew::config::tapsdir}/josegonzalez-php",
    require => Exec['tap-homebrew-dupes']
  }

  package { 'php54':
    install_options => ['--with-homebrew-openssl', '--with-imap', '--with-mysql', '--with-pgsql', '--with-fpm', '--with-suhosin'],
    require => Exec['tap-josegonzalez-php']
  }

  package { [
      'php54-intl',
      'php54-memcache',
      'php54-memcached',
      'php54-apc',
      'php54-geoip',
      'php54-xdebug'
    ]:
    provider => homebrew,
    require => Package['php54']
  }

  package { 'imagemagick': }

  package { [
      'ctags',
      'ec2-api-tools'
    ]:
    provider => homebrew
  }

  # Because `package` always fails in succeeding calls
  exec { 'install-gpg':
    command => 'brew install gpg',
    returns => [0, 1]
  }

  ruby::gem { 'capistrano for 2.0.0':
    gem => 'capistrano',
    ruby => '2.0.0'
  }

  ruby::gem { 'knife-solo for 2.0.0':
    gem => 'knife-solo',
    ruby => '2.0.0'
  }

  ruby::gem { 'railsless-deploy for 2.0.0':
    gem => 'railsless-deploy',
    ruby => '2.0.0'
  }

  ruby::gem { 'trollop for 2.0.0': 
    gem => 'trollop',
    ruby => '2.0.0'
  }
}
