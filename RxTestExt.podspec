#
# Be sure to run `pod lib lint RxTestExt.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxTestExt'
  s.version          = '0.0.5'
  s.summary          = 'A short description of RxTestExt.'
  s.description      = 'This is a set of extension functions that helps you write Rxtests in a declarative manor. 

The aim is to improve the readability and minimise the risk of making errors in boiler plate code. 

Much of the inspiration for these extensions came from the RxJava2'
  
  s.homepage         = 'https://github.com/markGilchrist/RxTestExt'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'markGilchrist' => 'theheadchef@gameforeverything.com' }
  s.source           = { :git => 'https://github.com/markGilchrist/RxTestExt.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '11.0'

  s.source_files = 'RxTestExt/Classes/**/*'
  s.swift_version = '5.0'
  
  s.dependency 'RxSwift', '5.0'
  s.dependency 'RxTest', '5.0'
end
