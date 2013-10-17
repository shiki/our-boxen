
# Packages for web developers (PHP)

class fufulabs_web {
  require homebrew
  require fufulabs
 
  include python
  include nginx
  include memcached
  include redis
  include mysql
  include beanstalk
  include vagrant
  include mongodb

  package { 'Sequel_Pro':
    provider => 'appdmg',
    source => 'http://sequel-pro.googlecode.com/files/sequel-pro-1.0.1.dmg'
  }

  package { 'MySQL Workbench':
    provider => 'appdmg',
    source => 'http://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-gpl-5.2.47-osx-i686.dmg'
  }

  # PHP
  #################################################################################################

  package { 'graphicsmagick': }
  package { 'imagemagick': }
  package { 'josegonzalez/php/composer': }

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
      'php54-mcrypt',
      'php54-mongo'
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

  # Important: This will break if PHP gets upgraded to a higher version.
  # https://github.com/sebastianbergmann/phpunit/issues/396#issuecomment-10406542
  exec { 'fix-pear-for-homebrew':
    command => 'chmod -R ug+w /opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php && pear config-set php_ini /opt/boxen/homebrew/etc/php/5.4/php.ini',
    require => Package['php54']
  }

  exec { 'pear-auto-discover':
    command => 'pear config-set auto_discover 1',
    require => Exec['fix-pear-for-homebrew']
  }

  exec { 'pear-install-system-daemon': 
    command => 'pear install System_Daemon',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/System/Daemon.php',
    require => Exec['pear-auto-discover']
  }

  exec { 'pear-install-code-sniffer':
    command => 'pear install PHP_CodeSniffer',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/PHP/CodeSniffer.php',
    require => Exec['pear-auto-discover']
  }

  exec { 'pear-discover-phpunit': 
    command => 'pear channel-discover pear.phpunit.de',
    require => Exec['pear-auto-discover'],
    returns => [0, 1]
  }

  # PHP Unit packages
  exec { 'pear-install-phpunit':
    command => 'pear install pear.phpunit.de/PHPUnit',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/PHPUnit/Autoload.php',
    require => Exec['pear-discover-phpunit']
  }
  exec { 'pear-install-phpunit-selenium':
    command => 'pear install pear.phpunit.de/PHPUnit_Selenium',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/PHPUnit/Extensions/SeleniumTestSuite.php',
    require => Exec['pear-install-phpunit']
  }
  exec { 'pear-install-phpunit-dbunit':
    command => 'pear install phpunit/DbUnit',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/PHPUnit/Extensions/Database/Autoload.php',
    require => Exec['pear-install-phpunit']
  }
  exec { 'pear-install-phpunit-story':
    command => 'pear install phpunit/PHPUnit_Story',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/PHPUnit/Extensions/Story/Autoload.php',
    require => Exec['pear-install-phpunit']
  }
  exec { 'pear-install-phpunit-invoker':
    command => 'pear install phpunit/PHP_Invoker',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/PHP/Invoker.php',
    require => Exec['pear-install-phpunit']
  }

  exec { 'pear-install-apigen':
    command => 'pear install pear.apigen.org/apigen',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.15/lib/php/ApiGen/Config.php',
    require => Exec['pear-auto-discover']
  }

  exec { 'pecl-install-xhprof':
    command => 'pecl install xhprof-beta',
    creates => '/opt/boxen/homebrew/Cellar/php54/5.4.20/lib/php/extensions/no-debug-non-zts-20100525/xhprof.so',
    require => Exec['fix-pear-for-homebrew']
  }

  # Others
  #################################################################################################

  package { [
      'ctags',
      'ec2-api-tools',
      'nmap',
      'lftp',
      'ssh-copy-id'
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

  ruby::gem { 'jekyll for 2.0.0': 
    gem => 'jekyll',
    ruby => '2.0.0'
  }

  ruby::gem { 'rdiscount for 2.0.0': 
    gem => 'rdiscount',
    ruby => '2.0.0'
  }

  # Node packages
  ##################################################################################################

  nodejs::module { 'coffee-script':
    node_version => 'v0.10.7'
  }
  nodejs::module { 'less':
    node_version => 'v0.10.7'
  }
  nodejs::module { 'grunt-cli':
    node_version => 'v0.10.7'
  }
}
