resource "shoreline_notebook" "blocked_processes_in_cassandra" {
  name       = "blocked_processes_in_cassandra"
  data       = file("${path.module}/data/blocked_processes_in_cassandra.json")
  depends_on = [shoreline_action.invoke_analyze_logs_and_monitor_perf_metrics,shoreline_action.invoke_long_running_query_optimizer]
}

resource "shoreline_file" "analyze_logs_and_monitor_perf_metrics" {
  name             = "analyze_logs_and_monitor_perf_metrics"
  input_file       = "${path.module}/data/analyze_logs_and_monitor_perf_metrics.sh"
  md5              = filemd5("${path.module}/data/analyze_logs_and_monitor_perf_metrics.sh")
  description      = "Identify the cause of the blocked processes by analyzing the system logs and monitoring performance metrics."
  destination_path = "/agent/scripts/analyze_logs_and_monitor_perf_metrics.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "long_running_query_optimizer" {
  name             = "long_running_query_optimizer"
  input_file       = "${path.module}/data/long_running_query_optimizer.sh"
  md5              = filemd5("${path.module}/data/long_running_query_optimizer.sh")
  description      = "Check for any long-running queries or transactions that may be causing the blocking and optimize them if possible."
  destination_path = "/agent/scripts/long_running_query_optimizer.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_analyze_logs_and_monitor_perf_metrics" {
  name        = "invoke_analyze_logs_and_monitor_perf_metrics"
  description = "Identify the cause of the blocked processes by analyzing the system logs and monitoring performance metrics."
  command     = "`chmod +x /agent/scripts/analyze_logs_and_monitor_perf_metrics.sh && /agent/scripts/analyze_logs_and_monitor_perf_metrics.sh`"
  params      = ["PATH_TO_PERF_METRICS","PATH_TO_LOG_FILE"]
  file_deps   = ["analyze_logs_and_monitor_perf_metrics"]
  enabled     = true
  depends_on  = [shoreline_file.analyze_logs_and_monitor_perf_metrics]
}

resource "shoreline_action" "invoke_long_running_query_optimizer" {
  name        = "invoke_long_running_query_optimizer"
  description = "Check for any long-running queries or transactions that may be causing the blocking and optimize them if possible."
  command     = "`chmod +x /agent/scripts/long_running_query_optimizer.sh && /agent/scripts/long_running_query_optimizer.sh`"
  params      = ["PATH_TO_CASSANDRA_HOME_DIRECTORY"]
  file_deps   = ["long_running_query_optimizer"]
  enabled     = true
  depends_on  = [shoreline_file.long_running_query_optimizer]
}

