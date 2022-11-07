resource "newrelic_alert_policy" "Test_terra" {
  name = "hs-test"
}

resource "newrelic_nrql_alert_condition" "test_alert" {
  account_id                     = 3627436
  policy_id                      = newrelic_alert_policy.Test_terra.id
  type                           = "static"
  name                           = "HS-Syn-Alert"
  description                    = "Alert"
  runbook_url                    = "https://www.gmail.com"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "static"
  fill_value                     = 1.0
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 120
  expiration_duration            = 120
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "SELECT percentage(count(*), WHERE result = 'SUCCESS') FROM SyntheticCheck WHERE monitorName = 'Step_Monitor_Portfolio'"
  }
  critical {
    operator              = "above"
    threshold             = 3.5
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = 2
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }

}

