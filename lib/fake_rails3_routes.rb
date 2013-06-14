require "fake_rails3_routes/version"
require 'fake_rails3_routes/mapper'

module FakeRails3Routes
  def self.draw(&block)
    if Rails.version >= "3.0"
      # we're on rails 3, no need to emulate
      Rails.application.class.routes.draw(&block)
    else
      ActionController::Routing::Routes.draw do |map|
        mapper = FakeRails3Routes::Mapper.new(map)
        mapper.instance_exec(&block)
      end
    end
  end
end
