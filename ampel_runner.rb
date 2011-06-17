$: << File.dirname(__FILE__) 
require 'ci_status_parser'
require 'ampel_switcher'

status_parser = CiStatusParser.new(
  'http://192.168.1.4:8080/cc.xml', 
  'betterplace_ci',
  '13:19',
  '13:22'
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