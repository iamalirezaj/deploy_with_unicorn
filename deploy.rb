#!/usr/bin/env ruby
#
# Deploy rails application with unicorn and nginx

require 'optparse'
require 'bundler'

options = {}

# Configure the command line
OptionParser.new do |parser|

  parser.banner = "Usage: deploy.rb [options]"

  parser.on("-s", "--start", "Start the deploy") do |v|
    options[:start] = v
  end

  options[:pid_file] = '#{workdir}/tmp/pids/unicorn.pid'
  parser.on("-p", "--pid-file file", "Pid file path") do |v|
    options[:pid_file] = v
  end

  options[:errors_file] = '#{workdir}/tmp/log/unicorn_error.log'
  parser.on("-e", "--errors-file file", "Errors file path") do |v|
    options[:errors_file] = v
  end

  options[:output_file] = '#{workdir}/tmp/log/unicorn_output.log'
  parser.on("-o", "--output-file file", "Output file path") do |v|
    options[:output_file] = v
  end

  options[:socket_file] = '#{workdir}/tmp/socket/unicorn.sock'
  parser.on("-k", "--socket-file file", "Output file path") do |v|
    options[:socket_file] = v
  end

  options[:workers] = 2
  parser.on("-w", "--workers num", "Worker processes") do |v|
    options[:workers] = v
  end

  options[:timeout] = 30
  parser.on("-t", "--timeout num", "Timeout") do |v|
    options[:timeout] = v
  end
end.parse!

def create_config_file(options, unicorn_config_file = "#{Dir.pwd}/config/unicorn.rb")

  puts "Creating unicorn config file in #{unicorn_config_file}"

  # Create unicorn config file in config directory
  File.open(unicorn_config_file, 'w') { |unicorn|

    # Write custom configures
    unicorn.write('# Get current working directory
workdir = File.expand_path( "../../" , __FILE__)

# set working directory
working_directory workdir

# create pid file
pid "' + options[:pid_file] + '"

# create log files
stderr_path "' + options[:errors_file] + '"
stdout_path "' + options[:output_file] + '"

# create socket file for listening
listen "' + options[:socket_file] + '"

# set working processes
worker_processes ' + options[:workers].to_s + '

# set timeout
timeout ' + options[:timeout].to_s )

  }

  unicorn_config_file
end

# Start the deploy
if options[:start]

  file = create_config_file(options)

  Bundler.clean_exec("unicorn -c #{file} -D")
end