ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def assert_valid(resource, text = nil)
    if text.present?
      assert resource.valid?, text
    else
      assert resource.valid?, "expected #{resource.model_name} to be valid"
    end
  end

  def refute_valid(resource, text = nil)
    if text.present?
      refute resource.valid?, text
    else
      refute resource.valid?, "expected #{resource.model_name} to not be valid"
    end
  end
end
