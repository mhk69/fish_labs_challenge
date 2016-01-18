RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

RSpec.configure do |conf|
	conf.include Rack::Test::Methods
	conf.include FactoryGirl::Syntax::Methods

	FactoryGirl.find_definitions

	conf.before(:suite) do
		DatabaseCleaner.clean_with(:truncation)
	end

	conf.before(:each) do
		DatabaseCleaner.strategy = :transaction
	end

	conf.before(:each, :js => true) do
		DatabaseCleaner.strategy = :truncation
	end

	conf.before(:each) do
		DatabaseCleaner.start
	end

	conf.after(:each) do
		DatabaseCleaner.clean
	end
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app FishLabsChallenge::App
#   app FishLabsChallenge::App.tap { |a| }
#   app(FishLabsChallenge::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
