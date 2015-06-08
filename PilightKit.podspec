#
# Be sure to run `pod lib lint PilightKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PilightKit"
  s.version          = "0.1.2"
  s.summary          = "PilightKit offers a simple Objecive-C library to access a pilight server."
  s.description      = "PilightKit is a easy to use Objective-C library to connect and interact with a pilight server."
  s.homepage         = "https://github.com/dittsche/PilightKit"
  s.license          = 'MIT'
  s.author           = { "Alexander Dittrich" => "alexander.dittrich@me.com" }
  s.source           = { :git => "https://github.com/dittsche/PilightKit.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PilightKit' => ['Pod/Assets/*.png']
  }

  s.dependency 'CocoaAsyncSocket'
  s.dependency 'CocoaLumberjack'
end
