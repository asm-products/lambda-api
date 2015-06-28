require 'mailchimp'

class MockMailchimp
  class Mock
    def self.mock(mocked)
      methods = mocked.instance_methods
                .reject { |m| instance_methods.include? m }

      methods.each do |name|
        define_method name do |*args|
          msg = "MockMailchimp: Call #{mocked}##{name} with (#{args.join(', ')})"
          Rails.logger.debug msg
          nil
        end
      end
    end

    def initialize(*_args)
    end
  end

  class API < Mock
    mock Mailchimp::API

    def lists
      Lists.new
    end
  end

  class Lists < Mock
    mock Mailchimp::Lists
  end
end
