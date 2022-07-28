RSpec.configure do |config|
  headless = ENV.fetch('HEADLESS', true) != 'false'

  # rack_test is faster, but we won't have scrreshots if something fails
  # hence switch everything to selenium so that we can have screenshots if something fails.
  #
  # config.before(:each, type: :system) do
  # driven_by :rack_test
  # end

  config.before :each, type: :system do
    puts "Running headless" if headless
    url = if headless
            "http://#{ENV.fetch('SELENIUM_REMOTE_HOST', nil)}:4444/wd/hub"
          else
            'http://host.docker.internal:9515'
          end
puts "created url #{url}"
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage window-size=1536,752]
      }
    )

    driven_by :selenium, using: :chrome, options: {
      browser: :remote,
      url: url,
      capabilities: capabilities
    }

    # Find Docker IP address
    Capybara.server_host = if headless
                             `/sbin/ip route|awk '/scope/ { print $9 }'`.strip
                           else
                             '0.0.0.0'
                           end
    Capybara.server_port = '43447'
    session_server       = Capybara.current_session.server
    Capybara.app_host    = "http://#{session_server.host}:#{session_server.port}"
  end

  config.after :each, type: :system, js: true do
    page.driver.browser.manage.logs.get(:browser).each do |log|
      case log.message
      when /This page includes a password or credit card input in a non-secure context/
        # Ignore this warning in tests
        next
      else
        message = "[#{log.level}] #{log.message}"
        raise message
      end
    end
  end
end
