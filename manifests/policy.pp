# == Class: rabbitmq::policy
#
class rabbitmq::policy {
  define manage_policy(
    $policyname   = $name,
    $ensure       = 'present',
    $pattern      = '.*',
    $priority     = '0',
    $applyto      = 'all',
    $definitions  = { "ha-mode" => "all", "ha-sync-mode" => "automatic" },
  ) {

    validate_string   ( $policyname                   )
    validate_re       ( $ensure, ['present','absent'] )
    validate_string   ( $pattern                      )
    validate_integer  ( $priority                     )
    validate_string   ( $applyto                      )
    validate_hash     ( $definitions                  )

    rabbitmq_policy { $policyname:
      ensure        => $ensure,
      pattern       => $pattern,
      priority      => $priority,
      applyto       => $applyto,
      definition    => $definitions,
    }
  }

  $policy_hash = hiera('rabbitmq::policy')
  create_resources(manage_policy, $policy_hash)

}