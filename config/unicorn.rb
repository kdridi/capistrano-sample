working_directory File.expand_path("../..", __FILE__)

pid File.expand_path("../../tmp/unicorn.pid", __FILE__)
stderr_path File.expand_path("../../log/unicorn.log", __FILE__)
stdout_path File.expand_path("../../log/unicorn.log", __FILE__)

listen File.expand_path("../../tmp/unicorn.sock", __FILE__)
worker_processes 4
timeout 30
