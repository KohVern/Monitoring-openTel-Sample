provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_prometheus_workspace" "amp" {
  alias = "otel-amp"
  
  tags = {
    Name        = "OpenTelemetry AMP"
    Environment = "dev"
  }
}

resource "aws_iam_role" "grafana_role" {
  name = "grafana-service-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "grafana.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "Grafana Service Role"
    Environment = "dev"
  }
}

resource "aws_iam_role_policy" "grafana_amp_access" {
  name = "GrafanaAMPAccess"
  role = aws_iam_role.grafana_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "aps:ListWorkspaces",
          "aps:DescribeWorkspace",
          "aps:QueryMetrics",
          "aps:GetLabels",
          "aps:GetSeries",
          "aps:GetMetricMetadata"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_grafana_workspace" "amg" {
  name                     = "otel-grafana"
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  permission_type          = "SERVICE_MANAGED"
  role_arn                = aws_iam_role.grafana_role.arn

  configuration = jsonencode({
    plugins = {
      pluginAdminEnabled = true
    }
    unifiedAlerting = {
      enabled = true
    }
  })
  
  tags = {
    Name        = "OpenTelemetry Grafana"
    Environment = "dev"
  }
}

resource "aws_grafana_role_association" "admin_group_access" {
  workspace_id = aws_grafana_workspace.amg.id
  role         = "ADMIN"
  group_ids    = ["f92aa5ec-f061-701a-c0af-8b14ea59815c"]
}

output "amp_workspace_id" {
  value = aws_prometheus_workspace.amp.id
}

output "amp_remote_write_url" {
  value = "${aws_prometheus_workspace.amp.prometheus_endpoint}api/v1/remote_write"
}

output "grafana_workspace_url" {
  value = aws_grafana_workspace.amg.endpoint
}