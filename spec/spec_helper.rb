require "bundler"
Bundler.require

require "stairs"

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include MockStdIO

  config.before(:all, &:silence_output)
  config.after(:all, &:enable_output)
end