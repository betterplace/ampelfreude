$: << File.dirname(__FILE__) 
require 'ci_status_parser'
require 'ampel_switcher'

status_parser = CiStatusParser.new('http://192.168.1.4:8080/cc.xml', 'betterplace_ci')

loop do 
  if(status_parser.update && status_parser.state_changed?)
    if(status_parser.build_running? && !status_parser.last_build_successful?)
      AmpelSwitcher.green_on
      AmpelSwitcher.red_on
    elsif(status_parser.last_build_successful?)
      AmpelSwitcher.green_on
      AmpelSwitcher.red_off
    else
      AmpelSwitcher.red_on
      AmpelSwitcher.green_off
    end
  else
    AmpelSwitcher.red_off
    AmpelSwitcher.green_off
  end
  
  sleep(5)
end