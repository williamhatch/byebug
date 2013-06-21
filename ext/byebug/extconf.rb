require 'mkmf'

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

if RUBY_VERSION < "2.0"
  STDERR.print("Ruby version is too old\n")
  exit(1)
end

if RbConfig::MAKEFILE_CONFIG['CC'] =~ /gcc/
  $CFLAGS = ' -std=c99 -Wall -Werror'
  $CFLAGS += ' -g3' if ENV['debug']
end

dir_config("ruby")
create_makefile("byebug")
