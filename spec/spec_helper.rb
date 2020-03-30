require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require_relative '../app/app.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app() RepoSearchApp end
end

RSpec.configure { |c| c.include RSpecMixin }
