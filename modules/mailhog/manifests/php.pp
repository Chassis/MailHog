class mailhog::php {
	file { '/etc/php5/conf.d/mailhog.ini':
		content => template('mailhog/php.ini.erb'),
		notify => Service['php5-fpm'],
	}
}