class AmpelSwitcher
  
  # Ports/number of the power socket for the ligh
  GREEN = 1
  RED = 2
  
  def blink_for_init
    green_off
    red_off
    green_on
    red_on
    sleep(3)
  end
  
  def set_build_state(status_parser)
    return unless(status_parser.state_changed?)

    if(status_parser.build_running? && !status_parser.last_build_successful?)
      green_on
      red_on
    elsif(status_parser.last_build_successful?)
      green_on
      red_off
    else
      red_on
      green_off
    end
  end
  
  def set_error_state(status_parser)
    AmpelSwitcher.red_off
    AmpelSwitcher.green_off
  end
  
  def self.green_on
    switch_light(GREEN, true)
  end
  
  def self.green_off
    switch_light(GREEN, false)
  end
  
  def self.red_on
    switch_light(RED, true)
  end
  
  def self.red_off
    switch_light(RED, false)
  end
  
  private
  
  def self.switch_light(socket, value)
    `/usr/bin/env sispmctl -#{value ? 'o' : 'f'} #{socket}` rescue nil
  end
  
end