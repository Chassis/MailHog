class { 'mailhog': }
class { 'mailhog::php':
	require => Class['mailhog']
}