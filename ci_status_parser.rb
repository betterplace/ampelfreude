require 'open-uri'
require 'nokogiri'
require 'time'

class CiStatusParser
  
  attr_accessor :uri, :project_name, :project_node
  
  def initialize(uri, project_name, start_time, stop_time)
    @uri = uri
    @project_name = project_name
    @start_time = start_time
    @stop_time = stop_time
  end
  
  def update
    doc = Nokogiri::XML(open(uri))
    update_state
    @project_node = doc.xpath("//Projects/Project[@name='#{project_name}']").first
  rescue
    @project_node = nil
    @old_state = nil
  end
  
  def state
    return nil unless @project_node
    [last_build_successful?, build_running?, active?]
  end
  
  def update_state
    previous_old_state = @old_state
    @old_state = state
    @state_changed = (@old_state != previous_old_state)
  end
  
  def state_changed?
    @state_changed
  end
  
  def last_build_successful?
    raise 'Last update failed' unless project_node
    @project_node.attributes['lastBuildStatus'].value == 'Success'
  end
  
  def build_running?
    raise 'Last update failed' unless project_node
    @project_node.attributes['activity'].value != 'Sleeping'
  end
  
  def active?
    day = Time.now.strftime("%a")
    (Time.now > Time.parse(@start_time) && Time.now < Time.parse(@stop_time) && day != "Sat" && day != "Sun")
  end
  
end