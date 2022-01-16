#
#  Be sure to run `pod spec lint CMTaiwanStockIndexKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "FlowChartKit"
  s.version      = "1.0.0"
  s.summary      = "Drawing link line for views as flow chart"

  s.description  = <<-DESC
    description of the pod here.
                   DESC

  s.homepage     = 'https://github.com/kkaychang/FlowChartKit.git'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'KayChang' => 'kaykwing@gmail.com' }
  s.source       = {
      :git => 'git@github.com:kkaychang/FlowChartKit.git', :tag => s.version
  }

  s.ios.deployment_target = "11.0"

  s.source_files  = "FlowChartKit/Classes/*.{h,m,swift}", "FlowChartKit/Classes/**/*.{h,m,swift}"
  s.resource_bundles = {
      'FlowChartKit' => ['FlowChartKit/Assets/*.*']
  }

  s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4']

end
