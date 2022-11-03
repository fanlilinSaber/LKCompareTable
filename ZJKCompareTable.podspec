Pod::Spec.new do |s|
  s.name = "ZJKCompareTable"
  s.version = "1.0.0"
  s.summary = "简单的表格数据展示，类似汽车比较表格展示"
  s.homepage = "https://codeup.aliyun.com/5eb53cca38076f00011bcfd8/IOS/ZJKCompareTable"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { "Fan Li Lin" => '824589131.com' }
  s.platform = :ios, "10.0"
  s.swift_versions = ["5.0"]
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.source = { :git => 'https://github.com/fanlilinSaber/ZJKCompareTable.git', :tag => "v#{s.version}" }
  s.source_files = 'Sources/**/*.swift'
  s.dependency "SnapKit"

end
