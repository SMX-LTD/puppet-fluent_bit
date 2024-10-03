// Test the config.rb function with some yaml input

require 'yaml'
require File.expand_path('../../lib/fluent_bit/config.rb', __FILE__)

yaml = "
input-kernel:
    service: INPUT
    name: kmsg
    tag: 'kernel'
filter-syslog-1:
    service: 'FILTER'
    name: modify
    match: syslog
    add:
      - 'source.workload foo'
      - 'source.env dev'
      - 'source.region ae'
      - 'source.hostname foo.bar.com'
filter-syslog-2:
    service: 'FILTER'
    name: lua
    match: syslog
    script: /opt/smx/fluent/lua/pritofaclvl.lua
    call: pritofaclvl

"
parsed = YAML.load(yaml)

conf = FluentBitConfig.generate(parsed)

puts conf


   

