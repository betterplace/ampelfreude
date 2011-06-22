$: << File.dirname(__FILE__) 
require 'ci_status_parser'
require 'ampel_switcher'

ENV["TZ"] = "Europe/Rome"

status_parser = CiStatusParser.new(
  'http://192.168.1.4:8080/cc.xml', 
  'betterplace_ci',
  '09:00',
  '19:00'
  )

AmpelSwitcher.blink_for_init

loop do 
  if(status_parser.update)
    AmpelSwitcher.set_build_state(status_parser)
  else
    AmpelSwitcher.set_error_state(status_parser)
  end
  
  sleep(5)
end