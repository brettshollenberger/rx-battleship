require "pry"
require "pry-byebug"
require "rspec"
require "active_record"
require "yaml"

Dir[File.expand_path(File.join(__FILE__, "../../lib/**/*.rb"))].each  { |f| require f }
Dir[File.expand_path(File.join(__FILE__, "../support/**/*.rb"))].each { |f| require f }

ActiveRecord::Base.establish_connection(
  {:adapter => "mysql"}
    .merge(
      YAML.load(
        File.open(
          File.expand_path(File.join(__FILE__, "../../lib/config/database.yml"))
        )
      )["test"]
    )
)
