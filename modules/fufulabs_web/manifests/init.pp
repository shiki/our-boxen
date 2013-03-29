
# Packages for web developers (PHP)

class fufulabs_web {
  require homebrew
  require fufulabs

  include nginx
  include memcached
  include redis
  include mysql
  include beanstalk

  package { 'Sequel_Pro':
    provider => 'appdmg',
    source => 'http://sequel-pro.googlecode.com/files/sequel-pro-1.0.1.dmg'
  }

  # PHP
  #################################################################################################

  package { 'graphicsmagick': }
  package { 'imagemagick': }

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
      'php54-xdebug',
      'php54-mcrypt'
    ]:
    provider => homebrew,
    require => Package['php54']
  }

  package { 'qcachegrind': }
  exec { 'link-qcachegrind': 
    command => 'brew linkapps',
    require => Package['qcachegrind']
  }

  # PEAR packages
  #################################################################################################

  exec { 'pear-auto-discover':
    command => 'pear config-set auto_discover 1',
    require => Package['php54']
  }

  exec { 'pear-install-system-daemon': 
    command => 'pear install System_Daemon',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.12/lib/php/System/Daemon.php',
    require => Exec['pear-auto-discover']
  }

  exec { 'pear-install-code-sniffer':
    command => 'pear install PHP_CodeSniffer',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.12/lib/php/PHP/CodeSniffer.php',
    require => Exec['pear-auto-discover']
  }

  exec { 'pear-discover-phpunit': 
    command => 'pear channel-discover pear.phpunit.de',
    require => Exec['pear-auto-discover'],
    returns => [0, 1]
  }

  exec { 'pear-install-phpunit':
    command => 'pear install pear.phpunit.de/PHPUnit pear.phpunit.de/PHPUnit_Selenium phpunit/DbUnit',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.12/lib/php/PHPUnit/Autoload.php',
    require => Exec['pear-discover-phpunit']
  }

  exec { 'pear-install-apigen':
    command => 'pear install pear.apigen.org/apigen',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.12/lib/php/ApiGen/Config.php',
    require => Exec['pear-auto-discover']
  }

  # Others
  #################################################################################################

  package { [
      'ctags',
      'ec2-api-tools'
    ]:
    provider => homebrew
  }

  # Because `package` always fails in succeeding calls even if it was installed
  exec { 'install-gpg':
    command => 'brew install gpg',
    returns => [0, 1]
  }

  # Ruby gems
  #################################################################################################

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
