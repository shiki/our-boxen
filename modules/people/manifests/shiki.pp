
class people::shiki {
  notify { 'loading packages for shiki only': }

  include fufulabs_web

  include transmission
  include handbrake
  #include vlc
  include flux
  
  package { 'Pomodoro':
    provider => 'appdmg',
    source   => 'http://www.pomodoroapp.com/d/PomodoroApp.3.0.beta.dmg'
  }
}

