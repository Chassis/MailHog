class mailhog (
	$install_path = '/usr/local/src/mailhog',
	$php          = $mailhog_config[php]
) {
	file { [ $install_path, "$install_path/bin" ]:
		ensure => directory,
	}
	exec { 'mailhog download':
		command => "/usr/bin/curl -o $install_path/bin/mailhog -L https://github.com/mailhog/MailHog/releases/download/v0.1.8/MailHog_linux_amd64",
		require => [ Package['curl'], File[ "$install_path/bin" ] ],
		creates => "$install_path/bin/mailhog"
	}

	file { "$install_path/bin/mailhog":
		ensure => present,
		mode => "a+x",
		require => Exec['mailhog download']
	}

	file { '/usr/bin/mailhog':
		ensure => link,
		target => "$install_path/bin/mailhog",
		require => File[ "$install_path/bin/mailhog" ],
	}

	file { '/etc/init/mailhog.conf':
		content => template('mailhog/upstart.conf.erb'),
	}

	service { 'mailhog':
	    enable => true,
		ensure => running,
		hasrestart => true,
		hasstatus => true,
		require => [ File['/etc/init/mailhog.conf'], File['/usr/bin/mailhog'] ]
	}

	if ! defined(Package['curl']) {
		package { 'curl':
			ensure => installed,
		}
	}
}
