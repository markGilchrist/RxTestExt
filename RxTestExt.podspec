#
# Be sure to run `pod lib lint RxTestExt.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxTestExt'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RxTestExt.'
  s.description      = 'This is a set of extension funtions that helps you write Rx test in the same way you can in android'
  
  s.homepage         = 'https://github.com/markGilchrist/RxTestExt'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'markGilchrist' => 'theheadchef@gameforeverything.com' }
  s.source           = { :git => 'https://github.com/markGilchrist/RxTestExt.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.3'

  s.source_files = 'RxTestExt/Classes/**/*'
  
  s.dependency 'RxSwift'
  s.dependency 'RxTest'
end
