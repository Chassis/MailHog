# A Chassis extension to install and configure MailHog on your server
class mailhog (
	$config,
	$install_path = '/usr/local/src/mailhog',
	$php          = $config[php]
) {
	if ( ! empty( $config[disabled_extensions] ) and 'chassis/mailhog' in $config[disabled_extensions] ) {
		service { 'mailhog':
			ensure    => stopped,
			enable    => false,
			restart   => false,
			hasstatus => false,
		}
		file { "${install_path}/bin/mailhog":
			ensure  => absent,
		}
		file { '/usr/bin/mailhog':
			ensure  => absent
		}
		file { '/etc/init/mailhog.conf':
			ensure => absent
		}
	} else {
		file { [ $install_path, "${install_path}/bin" ]:
			ensure => directory,
		}
		exec { 'mailhog download':
			command => "/usr/bin/curl -o ${install_path}/bin/mailhog -L https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64",
			require => [ Package['curl'], File[ "${install_path}/bin" ] ],
			creates => "${install_path}/bin/mailhog"
		}

		file { "${install_path}/bin/mailhog":
			ensure  => present,
			mode    => 'a+x',
			require => Exec['mailhog download']
		}

		file { '/usr/bin/mailhog':
			ensure  => link,
			target  => "${install_path}/bin/mailhog",
			require => File[ "${install_path}/bin/mailhog" ],
		}

		if versioncmp($::operatingsystemmajrelease, '15.04') >= 0 {
			file { '/lib/systemd/system/mailhog.service':
				ensure  => 'file',
				content => template('mailhog/systemd.service.erb'),
			}
			File['/lib/systemd/system/mailhog.service'] -> Service['mailhog']
		} else {
			file { '/etc/init/mailhog.conf':
				content => template('mailhog/upstart.conf.erb'),
			}
			File['/etc/init/mailhog.conf'] -> Service['mailhog']
		}

		service { 'mailhog':
			ensure     => running,
			enable     => true,
			hasrestart => true,
			hasstatus  => true,
			require    => [ File['/usr/bin/mailhog'] ]
		}

		class { 'mailhog::php':
			require => Class['mailhog'],
			config  => $config
		}
	}

	if !defined(Package['curl']) {
		package { 'curl':
			ensure => installed,
		}
	}
}
