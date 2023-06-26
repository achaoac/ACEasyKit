Pod::Spec.new do |s|
  s.name = "ACEasyKit"
  s.version = "1.0.0"
  s.summary = "Simple project kit"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = "achaoacwang"
  s.homepage = "https://github.com/achaoac/ACEasyKit.git"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '11.0'
  s.ios.vendored_framework   = 'ios/ACEasyKit.framework'
end
