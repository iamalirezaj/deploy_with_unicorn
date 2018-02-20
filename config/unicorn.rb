# Get current working directory
workdir = File.expand_path( "../../" , __FILE__)

# set working directory
working_directory workdir

# create pid file
pid "#{workdir}/tmp/pids/unicorn.pid"

# create log files
stderr_path "#{workdir}/tmp/log/unicorn_error.log"
stdout_path "#{workdir}/tmp/log/unicorn_output.log"

# create socket file for listening
listen "#{workdir}/tmp/socket/unicorn.sock"

# set working processes
worker_processes 4

# set timeout
timeout 30