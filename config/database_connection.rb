def db_conf
  db_conf_file = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
  YAML.load(File.read(db_conf_file))
end

ActiveRecord::Base.establish_connection(db_conf[ENV['environment']])
