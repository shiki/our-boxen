
# Packages for iOS developers

class fufulabs_ios {
  require homebrew
 
  #package { 'mogenerator': }

  #ruby::gem { 'cocoapods for 2.0.0':
  #  gem => 'cocoapods',
  #  ruby => '2.0.0'
  #}

  package { 'crashlytics': 
    provider => 'compressed_app',
    source => 'https://ssl-download-crashlytics-com.s3.amazonaws.com/mac/builds/Crashlytics-latest.zip'
  }

  ruby::gem { 'cocoapods for 2.0.0':
    gem => 'cocoapods',
    ruby => '2.0.0'
  }
}
