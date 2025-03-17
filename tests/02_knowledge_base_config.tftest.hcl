run "plan_kb" {
  command = plan
  module {
    source = "./examples/knowledge-base-config"
  }
}

run "apply_kb" {
  command = apply
  module {
    source = "./examples/knowledge-base-config"
  }
}
