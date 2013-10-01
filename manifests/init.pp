# Internal: Install logrotate and configure it to read from /etc/logrotate.d
#
# Examples
#
#   include logrotate
class logrotate(
  $version = installed
) {
  package { 'logrotate':
    ensure => $version,
  }

  File {
    owner   => 'root',
    group   => 'root',
    require => Package['logrotate'],
  }

  file {
    '/etc/logrotate.conf':
      ensure  => file,
      mode    => '0644',
      source  => 'puppet:///modules/logrotate/etc/logrotate.conf';
    '/etc/logrotate.d':
      ensure  => directory,
      mode    => '0755';
  }

  case $::osfamily {
    'Debian': {
      include logrotate::defaults::debian
    }
    'RedHat': {
      include logrotate::defaults::redhat
    }
    'SuSE': {
      include logrotate::defaults::suse
    }
    default: { }
  }
}
