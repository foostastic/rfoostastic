ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_user(user)
    OmniAuth.config.mock_auth[:developer] = OmniAuth::AuthHash.new({
        :provider => 'developer',
        :uid => user.email,
        :info => {
          :name => user.name,
          :email => user.email
        }
    })

    get login_url
    follow_redirect!
    follow_redirect!
    assert_not_nil session[:current_user_id]
  end
end
