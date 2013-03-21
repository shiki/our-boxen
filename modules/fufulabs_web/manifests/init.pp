
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
}
