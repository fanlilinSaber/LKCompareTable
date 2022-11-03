Pod::Spec.new do |spec|
  spec.name = "ZJKCompareTable"
  spec.version = "1.0.0"
  spec.summary = "简单的表格数据展示，类似汽车比较表格展示"
  spec.homepage = "https://codeup.aliyun.com/5eb53cca38076f00011bcfd8/IOS/ZJKCompareTable"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Fan Li Lin" => '824589131.com' }
  spec.platform = :ios, "10.0"
  spec.swift_versions = ["5.0"]
  spec.frameworks = 'Foundation', 'UIKit'
  spec.requires_arc = true
  spec.source = { :git => 'https://codeup.aliyun.com/5eb53cca38076f00011bcfd8/IOS/ZJKCompareTable.git', :tag => 'v#{spec.version}', submodules: true }
  spec.source_files = 'Sources/**/*.swift'
  spec.dependency "SnapKit"

end
