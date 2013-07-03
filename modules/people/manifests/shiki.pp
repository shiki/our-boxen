
class people::shiki {
  notify { 'loading packages for shiki only': }

  include fufulabs_web
  include fufulabs_ios
  include fufulabs_gamedev

  include evernote
  include libreoffice

  include transmission
  include handbrake
  #include vlc
}

