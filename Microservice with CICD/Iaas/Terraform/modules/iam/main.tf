resource "aws_iam_role" "ecsServiceExecutionRole" {
  name = "ecsServiceExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecsServiceExecutionPolicy" {
  name = "ecsServiceExecutionPolicy"
  policy = file("modules/iam/ecsServiceExecutionPolicy.json")
}

resource "aws_iam_role_policy_attachment" "ecsServiceExecutionPolicyAttachment" {
  role       = aws_iam_role.ecsServiceExecutionRole.name
  policy_arn = aws_iam_policy.ecsServiceExecutionPolicy.arn
}