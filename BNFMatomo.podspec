require 'json'
package_json = JSON.parse(File.read('package.json'))

Pod::Spec.new do |s|

  s.name           = "BNFMatomo"
  s.version        = package_json["version"]
  s.summary        = package_json["description"]
  s.homepage       = package_json["homepage"]
  s.license        = package_json["license"]
  s.author         = { package_json["author"] => package_json["author"] }
  s.platform       = :ios, "10.0"
  s.source         = { :git => "#{package_json["repository"]["url"]}", :tag => "#{s.version}" }
  s.source_files   = 'ios/**/*.{h,m,swift}'
  s.swift_version  = '4.2'
  s.dependency 'React'
  s.dependency 'matomo-ios'

end
