
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

  package { [
      'gpg',
      'ctags',
      'ec2-api-tools'
    ]: 
  }
}
