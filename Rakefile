require_relative "./lib/app.rb"

include ActiveRecord::Tasks
DatabaseTasks.database_configuration = YAML.load_file('./lib/config/database.yml')
DatabaseTasks.db_dir                 = './lib/db'
DatabaseTasks.env                    = "development"
DatabaseTasks.migrations_paths       = %w(./lib/db/migrate)
DatabaseTasks.root                   = "./"

load 'active_record/railties/databases.rake'

namespace :db do
  task :generate_migration do
    sh "touch ./lib/db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_#{ENV["NAME"]}.rb"
  end
end
