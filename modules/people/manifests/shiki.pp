
class people::shiki {
  notify { 'loading packages for shiki only': }

  include fufulabs_web
  include fufulabs_ios

  include transmission
  include handbrake
  #include vlc
  include flux
}

