plan pe_status_check::status_report(
  Variant[TargetSpec,String] $target,
  Enum['pe_status_check', 'agent_status_check']] $which_fact                        = 'pe_status_check',
) {
  # Ensuring that the service task executes it's puppet-agent impl so
  # that we're parsing consistent output.
  $_target = get_targets($target)
  $_target.each |TargetSpec $feature_target| {
    enterprise_tasks::set_feature($feature_target, 'puppet-agent', true)
  }

  $results = run_task('facter_task':facter_task, $_target,
    fact    => $which_fact,
  )
  $status_hash = Hash($results.first().value())
  out::message("${which_fact} resource service found in state: ${status_hash}")

  return $status_hash,
}
