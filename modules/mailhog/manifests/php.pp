class mailhog::php {
	$vconfig = sz_load_config('/vagrant')
	if versioncmp( "${$vconfig[php]}", '5.6') > -1 {
		file { '/etc/php5/fpm/conf.d/mailhog.ini':
			content => template('mailhog/php.ini.erb'),
			notify  => Service['php5-fpm'],
			require => Package['php5-fpm'],
		}
	} else {
		file { '/etc/php/conf.d/mailhog.ini':
			content => template('mailhog/php.ini.erb'),
			notify  => Service['php5-fpm'],
			require => Package['php5-fpm'],
		}
	}
}
