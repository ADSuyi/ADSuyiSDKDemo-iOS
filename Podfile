# Uncomment the next line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

target 'ADSuyiSDKDemo-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks

  # Pods for ADSuyiSDKDemo-iOS
  pod 'ADSuyiSDK', '~> 3.8.0.11271'
  pod 'ADSuyiSDK', '~> 3.8.0.11271', :subspecs => [
    'ADSuyiSDKPlatforms/tianmu', # 天目  #必选
    'ADSuyiSDKPlatforms/gdt', # 优量汇(广点通）
    'ADSuyiSDKPlatforms/baidu', # 百度
    'ADSuyiSDKPlatforms/ks', # 快手(非内容版本，内容与非内容版本不可同时导入)
    'ADSuyiSDKPlatforms/mtg', # Mobvista(汇量)
    
 # ab二选一
 # a.不需要gromore
    'ADSuyiSDKPlatforms/bu', # 穿山甲(头条)
 # b.需要gromore
#    'ADSuyiSDKPlatforms/bu-without', # 穿山甲(头条)
#    'ADSuyiSDKPlatforms/gromore', # gromore
  ]
 # 以下为gromore的三方适配器，按需导入（优量汇已导入，无需额外导入）
  #pod 'CSJMAdmobAdapter',      '10.0.0.0'
  #pod 'CSJMKsAdapter',         '3.3.51.1.0'
  #pod 'CSJMUnityAdapter',      '4.3.0.0'
  #pod 'CSJMBaiduAdapter',      '5.322.0'
  #pod 'CSJMMintegralAdapter',  '7.3.6.0.2'
  #pod 'CSJMKlevinAdapter',     '2.11.0.211.1'
  #pod 'CSJMSigmobAdapter',     '4.9.4.0'
  
  pod 'MJRefresh'

end
