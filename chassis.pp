$mailhog_config = sz_load_config()
class { 'mailhog':
	php => $mailhog_config[php]
}
class { 'mailhog::php':
	require => Class['mailhog'],
}
