plan pe_status_check::exec_info(TargetSpec $targets) {
  return  run_task(exec, $targets,
    command => 'facter -p --json pe_status_check',
  ) {
    "${r.target.name}: ${r}"
  }
}
