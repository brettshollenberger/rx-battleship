require_relative "./lib/app.rb"

include ActiveRecord::Tasks
DatabaseTasks.database_configuration = YAML.load_file('./lib/config/database.yml')
DatabaseTasks.db_dir = './lib/db'
DatabaseTasks.env = "development"
DatabaseTasks.migrations_paths = %w(./lib/db/migrate)
DatabaseTasks.root = "./"

load 'active_record/railties/databases.rake'
