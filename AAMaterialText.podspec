#
# Be sure to run `pod lib lint AAMaterialText.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AAMaterialText'
  s.version          = '1.1'
  s.summary          = 'AAMaterialText is a customizable Text input field written in Swift 5.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
AAMaterialText is a customizable text field and text view to handle multiline dynamic text and customizable placeholder.
                       DESC

  s.homepage         = 'https://github.com/engrahsanali/AAMaterialText'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'engrahsanali' => 'hafiz.m.ahsan.ali@gmail.com' }
  s.source           = { :git => 'https://github.com/engrahsanali/AAMaterialText.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AAMaterialText/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AAMaterialText' => ['AAMaterialText/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.swift_version = '5.0'
end
