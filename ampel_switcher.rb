class AmpelSwitcher
  
  # Ports/number of the power socket for the ligh
  GREEN = 1
  RED = 2
  
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