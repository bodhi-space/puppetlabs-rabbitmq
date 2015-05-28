# == Class: rabbitmq::vhost
#
class rabbitmq::vhost {
  define manage_vhost(
    $vhostname   = $title,
    $ensure       = 'present',
  ) {

    validate_string   ( $vhost_name                   )
    validate_re       ( $ensure, ['present','absent'] )

    rabbitmq_vhost { $vhostname:
      ensure        => $ensure,
    }
  }

  $vhost_hash = hiera('rabbitmq::vhost')
  create_resources(manage_vhost, $vhost_hash)

}