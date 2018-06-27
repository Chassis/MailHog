# A Chassis extension to install and configure MailHog on your server
class mailhog::php (
	$config,
	$php = $config[php]
)
	{
		if versioncmp($php, '5.4') <= 0 {
			$php_package = 'php5'
			$php_dir = 'php5'
		}
		else {
			$short_ver = regsubst($php, '^(\d+\.\d+)\.\d+$', '\1')
			$php_package = $short_ver
			$php_dir = "php/${short_ver}"
		}
		if ( ! empty( $config[disabled_extensions] ) and 'chassis/mailhog' in $config[disabled_extensions] ) {
			file { "/etc/${php_dir}/fpm/conf.d/mailhog.ini":
				ensure  => absent,
				notify  => Service["php${php_package}-fpm"],
				require => Package["php${php_package}-fpm"],
			}

			file { "/etc/${php_dir}/cli/conf.d/mailhog.ini":
				ensure  => absent,
				require => Package["php${php_package}-cli"],
			}
		} else {
			file { "/etc/${php_dir}/fpm/conf.d/mailhog.ini":
				content => template('mailhog/mailhog.ini.erb'),
				notify  => Service["php${php_package}-fpm"],
				require => Package["php${php_package}-fpm"],
			}

			file { "/etc/${php_dir}/cli/conf.d/mailhog.ini":
				content => template('mailhog/mailhog.ini.erb'),
				require => Package["php${php_package}-cli"],
			}
		}
	}
