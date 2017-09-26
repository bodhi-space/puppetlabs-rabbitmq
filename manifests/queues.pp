# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2
#
# --- generic service ---

class rabbitmq::queues () {
 $queues = hiera_hash('rabbitmq::queues')

  define rabbitmq_queues(
    $queue      => $title,
    $user       => $user,
    $password   => $password,
    $durable    => $durable,
    $autodelete => false,
    $arguments  => {},
  ) { 

    rabbitmq_queue { $title:
      user       => $user,
      password   => $password,
      durable    => $durable,
      ensure     => present
      autodelete => $autodelete,
      arguments  => $arguments,
    }
  }

  create_resources(rabbitmq_queues, $queues)
}
