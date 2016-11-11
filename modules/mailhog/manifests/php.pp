class mailhog::php (
  $php = $mailhog_config[php]
)
{
  if versioncmp( "${$php}", '5.4') <= 0 {
    $php_package = 'php5'
    $php_dir = 'php5'
  }
  else {
    $php_package = "$php"
    $php_dir = "php/$php"
  }
  file { "/etc/${php_dir}/fpm/conf.d/mailhog.ini":
    content => template('mailhog/php.ini.erb'),
    notify  => Service["php${php_package}-fpm"],
    require => Package["php${php_package}-fpm"],
  }
}
