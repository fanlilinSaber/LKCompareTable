Pod::Spec.new do |s|
  s.name = "LKCompareTable"
  s.version = "1.0.6"
  s.summary = "类似汽车之家对比表格展示"
  s.homepage = "https://github.com/fanlilinSaber/LKCompareTable"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { "Fan Li Lin" => '824589131.com' }
  s.platform = :ios, "11.0"
  s.swift_versions = ["5.0"]
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.source = { :git => 'https://github.com/fanlilinSaber/LKCompareTable.git', :tag => "v#{s.version}" }
  s.source_files = 'Sources/**/*.swift'
  s.dependency "SnapKit"

end
