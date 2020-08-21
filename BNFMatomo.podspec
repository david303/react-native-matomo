require 'json'
package_json = JSON.parse(File.read('package.json'))

Pod::Spec.new do |s|

  s.name           = "BNFMatomo"
  s.version        = package_json["version"]
  s.summary        = package_json["description"]
  s.homepage       = "https://github.com/milkinteractive/react-native-matomo"
  s.license        = package_json["license"]
  s.author         = { package_json["author"] => package_json["author"] }
  s.platform       = :ios, "10.0"
  s.source         = { :git => "#{package_json["repository"]["url"]}.git", :tag => "#{s.version}" }
  s.source_files   = 'ios/**/*.{h,m,swift}'
  s.swift_version  = '4.2'
  s.dependency 'React'
  s.dependency 'MatomoTracker', :git => 'https://github.com/milkinteractive/matomo-sdk-ios.git', :tag => 'v7.2.0-2'

end
