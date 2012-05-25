$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
# require 'motion-testflight'
require 'YAML'

local_config = YAML::load(File.open('local_config.yml'))

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'ProtoMap'
  app.identifier = 'io.syntop.ProtoMap'
  app.device_family = :ipad
  app.interface_orientations = [:landscape_left, :landscape_right, :portrait, :portrait_upside_down]
  app.icons = ['icon-144.png']
  app.prerendered_icon = true
  
  app.vendor_project('vendor/vvosc-frameworks/VVBasics', :static, 
    :products => ['iphonesimulator.sdk/usr/local/lib/libVVBasics.a', 'iphoneos.sdk/usr/local/lib/libVVBasics.a']
  )
  app.vendor_project('vendor/vvosc-frameworks/VVOSC', :static, 
    :products => ['iphonesimulator.sdk/usr/local/lib/libVVOSC.a', 'iphoneos.sdk/usr/local/lib/libVVOSC.a']
  )
  
  app.frameworks << 'CFNetwork'
  app.frameworks << 'CoreImage'
  app.frameworks << 'QuartzCore'
  
  # app.testflight.sdk = 'vendor/TestFlightSDK'
  # app.testflight.api_token = local_config['testflight_api_token']
  # app.testflight.team_token = local_config['testflight_team_token']
end
