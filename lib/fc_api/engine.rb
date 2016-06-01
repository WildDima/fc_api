module FcApi
  class Engine < ::Rails::Engine
    isolate_namespace FcApi

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
