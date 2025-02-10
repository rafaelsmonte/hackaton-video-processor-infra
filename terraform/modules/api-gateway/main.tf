#============================================================================
# Authors: Thiago, Vitor, Rafael
# Description: Creates API Gateway
#============================================================================
resource "aws_apigatewayv2_api" "aws_apigatewayv2_api_hackaton" {
  name          = var.api_gateway_name
  protocol_type = var.api_gateway_protocol_type
  disable_execute_api_endpoint = false

  # Enable path normalization
  cors_configuration {
    allow_headers = ["*"]
    allow_methods = ["*"]
    allow_origins = ["*"]
    expose_headers = ["*"]
    max_age = 300
  }
}

resource "aws_apigatewayv2_authorizer" "aws_apigatewayv2_authorizer_hackaton" {
  api_id         = aws_apigatewayv2_api.aws_apigatewayv2_api_hackaton.id
  authorizer_type = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name            = "JWTAuthorizer"

  jwt_configuration {
    audience = ["${var.cognito_user_pool_client_user_accounts_id}"]
    issuer   = "https://cognito-idp.us-east-1.amazonaws.com/${var.cognito_user_pool_user_accounts_id}"
  }
}

#===========================================================
# Api gateway configuration for /signup at lambda function
#===========================================================
resource "aws_lambda_permission" "aws_lambda_permission_allow_api_gateway" {
  statement_id  = var.api_gateway_lambda_permission_statement_id
  action        = var.api_gateway_lambda_permission_action
  function_name = var.api_gateway_lambda_permission_function_name
  principal     = var.api_gateway_lambda_permission_principal
  source_arn    = "${aws_apigatewayv2_api.aws_apigatewayv2_api_hackaton.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "aaws_apigatewayv2_integration_lambda_integration" {
  api_id = aws_apigatewayv2_api.aws_apigatewayv2_api_hackaton.id
  integration_type = var.api_gateway_lambda_integration_integration_type
  integration_uri = var.api_gateway_lambda_integration_integration_uri
  payload_format_version = var.api_gateway_lambda_integration_payload_format_version

  request_parameters = {
    "overwrite:header.x-user-sub"   = "$context.authorizer.jwt.claims.sub"
    "overwrite:header.x-user-email" = "$context.authorizer.jwt.claims.email"
  }

  # Grant API Gateway permission to invoke your Lambda function
  depends_on = [aws_lambda_permission.aws_lambda_permission_allow_api_gateway]
}

resource "aws_apigatewayv2_route" "aws_apigatewayv2_route_signup" {
  api_id     = aws_apigatewayv2_api.aws_apigatewayv2_api_hackaton.id
  route_key  = "ANY /api/v1/auth/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.aaws_apigatewayv2_integration_lambda_integration.id}"
}

#============================================================
# Api gateway configuration for video processor apis
#============================================================
resource "aws_apigatewayv2_integration" "apigatewayv2_integration_video_processor_api_integration" {
  api_id            = aws_apigatewayv2_api.aws_apigatewayv2_api_hackaton.id
  integration_type  = var.api_gateway_video_processor_api_integration_type
  integration_method = var.api_gateway_video_processor_api_integration_method
  connection_type   = var.api_gateway_video_processor_api_connection_type
  integration_uri   = var.api_gateway_video_processor_api_integration_uri
}

resource "aws_apigatewayv2_route" "proxy_route_video_processor_api" {
  api_id     = aws_apigatewayv2_api.aws_apigatewayv2_api_hackaton.id
  route_key  = "ANY /api/v1/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.apigatewayv2_integration_video_processor_api_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_hackaton.id
}

#============================================================
# Api gateway configuration for prod stage
#============================================================
resource "aws_apigatewayv2_stage" "prod" {
  api_id    = aws_apigatewayv2_api.aws_apigatewayv2_api_hackaton.id
  name      = "$default"
  auto_deploy = var.api_gateway_auto_deploy
}
