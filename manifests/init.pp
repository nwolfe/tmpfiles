# TODO make the sandbox location a parameter
class tmpfiles {

  notify { "Custom fact PWD: $custom_fact_pwd": }
  notify { "External fact DATE: $external_fact_date": }

  filebucket { 'backups':
    # use central filebucket on the server
    path => false,
  }

  File {
    backup => backups,
  }

  $sandbox = '/Users/nwolfe/tmp/puppet-sandbox'

  notify { "Creating sandbox directory at $sandbox": }

  file { 'sandbox-directory':
    path   => "$sandbox",
    ensure => directory,
  }

  file { 'puppet-managed-content-file':
    path    => "$sandbox/puppet-managed-content-file",
    ensure  => present,
    content => "You can delete me, I'll just come back during the next Puppet run\n",
  }

  file { 'puppet-managed-source-file':
    path   => "$sandbox/puppet-managed-source-file",
    ensure => present,
    source => 'puppet:///modules/tmpfiles/source-file',
  }

  file { 'puppet-managed-binary-file':
    path   => "$sandbox/puppet-managed-binary-file",
    ensure => present,
    mode   => "0755",
    source => 'puppet:///modules/tmpfiles/binary-file',
  }

  file { 'puppet-managed-recursive-directory':
    path    => "$sandbox/puppet-managed-recursive-directory",
    source  => 'puppet:///modules/tmpfiles/source-recursive-directory',
    ensure  => directory,
    recurse => true,
  }

  file { 'puppet-managed-custom-mount-point-file':
    path   => "$sandbox/puppet-managed-custom-mount-point-file",
    ensure => present,
    source => 'puppet:///custom_mount_point/custom-mount-point-file',
  }
}
