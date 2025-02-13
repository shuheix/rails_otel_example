# frozen_string_literal: true

require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/all'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'rails-otel-example'
  c.use_all()

  endpoint = ENV.fetch('OTEL_EXPORTER_OTLP_ENDPOINT', 'http://localhost:4318')

  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(endpoint: endpoint)
    )
  )
end
