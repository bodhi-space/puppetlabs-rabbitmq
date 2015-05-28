# == Class: rabbitmq::userperms
#
class rabbitmq::userperms {
  define manage_userperms(
    $username         = $name,
    $configure_perms  = '.*',
    $read_perms       = '.*',
    $write_perms      = '.*'
  ) {

    validate_string   ( $username        )
    validate_string   ( $configure_perms )
    validate_string   ( $read_perms      )
    validate_string   ( $write_perms     )

    rabbitmq_user_permissions { $username:
      configure_permission => $config_perms,
      read_permission      => $read_perms,
      write_permission     => $write_perms,
    }
  }

  $userperms_hash = hiera_hash('rabbitmq::userperms')
  create_resources(manage_userperms, $userperms_hash)
}