RSpec.configure do |c|
  c.around(:example, show_exception: true) do |example|
    Rails.application.config.action_dispatch.show_exceptions = true
    example.run
    Rails.application.config.action_dispatch.show_exceptions = false
  end
end
