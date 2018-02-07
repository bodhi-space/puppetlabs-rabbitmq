# == Class: rabbitmq::user
#
class rabbitmq::user {
  define manage_user(
    $username       = $name,
    $ensure         = 'present',
    $password       = undef,
    $tags           = ['puppet'],
    $admin          = false,
  ) {

    if $password == undef {
      fail("No password supplied for user '$username'.")
    } else {
      validate_string ( $password                     )
    }
    validate_re       ( $ensure, ['present','absent'] )
    validate_array    ( $tags                         )
    validate_bool     ( $admin                        )

    rabbitmq_user { $username:
      admin         => $admin,
      password      => $password,
      tags          => $tags,
      ensure        => $ensure,
    }
  }

  $user_hash = hiera_hash('rabbitmq::user')
  create_resources(manage_user, $user_hash)

}
