$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-testflight'
require 'YAML'

local_config = YAML::load(File.open('local_config.yml'))

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'ProtoMap'
  app.identifier = 'io.syntop.ProtoMap'
  app.device_family = :ipad
  app.interface_orientations = [:landscape_left, :landscape_right]
  app.icons = ['icon-144.png']
  app.prerendered_icon = true
  
  app.vendor_project('vendor/CocoaOSC', :xcode)
  app.frameworks << 'CFNetwork'
  
  app.testflight.sdk = 'vendor/TestFlightSDK'
  app.testflight.api_token = local_config['testflight_api_token']
  app.testflight.team_token = local_config['testflight_team_token']
end
