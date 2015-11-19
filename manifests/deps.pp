# == Class: rbenv::deps
#
# This module manages rbenv dependencies and should *not* be called directly.
#
# === Authors
#
# Justin Downing <justin@downing.us>
#
# === Copyright
#
# Copyright 2013 Justin Downing
#
class rbenv::deps {
  include ::stdlib

  anchor { 'rbenv::deps::begin': } ->
  anchor { 'rbenv::deps::end': }

  case $::osfamily {
    'Debian': {
      include rbenv::deps::debian
      $group = 'adm'
      Anchor['rbenv::deps::begin'] ->
      Class['rbenv::deps::debian'] ->
      Anchor['rbenv::deps::end']
    }
    'RedHat': {
      include rbenv::deps::redhat
      $group = 'wheel'
      Anchor['rbenv::deps::begin'] ->
      Class['rbenv::deps::redhat'] ->
      Anchor['rbenv::deps::end']
    }
    'Suse': {
      include rbenv::deps::suse
      $group = 'users'
      Anchor['rbenv::deps::begin'] ->
      Class['rbenv::deps::suse'] ->
      Anchor['rbenv::deps::end']
    }
    default: {
      fail('The rbenv module currently only suports Debian, RedHat, and Suse.')
    }
  }
}
