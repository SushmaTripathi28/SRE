# modules/alerting_module/main.tf

variable "email_address" {
  description = "Email address for notifications"
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Notification Channel"
  type         = "email"
  
  labels = {
    email_address = var.email_address
  }
}

resource "google_monitoring_alert_policy" "cpu_alert_policy" {
  display_name = "CPU Utilization > 50%"
  
  conditions {
    display_name = "Condition 1"
    
    condition_threshold {
      comparison       = "COMPARISON_GT"
      duration         = "60s"
      filter           = resource.type = "gce_instance" AND metric.type = "compute.googleapis.com/instance/cpu/utilization"
      threshold_value  = "0.5"
      
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_channel_strategy {
      renotify_interval            = "1800s"
      notification_channel_names  = [google_monitoring_notification_channel.email.name]
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.name]

  user_labels = {
    severity = "warning"
  }
}
