# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2
#
# --- generic service ---
#

class rabbitmq::queues () {
  $queues = hiera_hash('rabbitmq::queues')

  define rabbitmq_queues (
    $queue        = $title,
    $user         = $user,
    $password     = $password,
    $durable      = $durable,
    $auto_delete  = false,
    $arguments    = {},
  ) { 
    rabbitmq_queue { $title:
      user        => $user,
      password    => $password,
      durable     => $durable,
      ensure      => present,
      auto_delete => $auto_delete,
      arguments   => $arguments,
    }
  }

  create_resources(rabbitmq_queues, $queues)
}
