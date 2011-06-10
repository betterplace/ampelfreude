require 'open-uri'
require 'nokogiri'

class CiStatusParser
  
  attr_accessor :uri, :project_name, :project_node
  
  def initialize(uri, project_name)
    @uri = uri
    @project_name = project_name
  end
  
  def update
    doc = Nokogiri::XML(open(uri))
    @project_node = doc.xpath("//Projects/Project[@name='#{project_name}']").first
  rescue
    @project_node = nil
  end
  
  def last_build_successful?
    raise 'Last update failed' unless project_node
    @project_node.attributes['lastBuildStatus'].value == 'Success'
  end
  
  def build_running?
    raise 'Last update failed' unless project_node
    @project_node.attributes['activity'].value != 'Sleeping'
  end
  
end