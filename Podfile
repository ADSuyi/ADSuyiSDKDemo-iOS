# Uncomment the next line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

target 'ADSuyiSDKDemo-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks

  # Pods for ADSuyiSDKDemo-iOS
  pod 'ADSuyiSDK', '~> 3.9.1.03144'
  pod 'ADSuyiSDK', '~> 3.9.1.03144', :subspecs => [
    'ADSuyiSDKPlatforms/tianmu', # 天目  #必选
#    'ADSuyiSDKPlatforms/gdt', # 优量汇(广点通）
#    'ADSuyiSDKPlatforms/baidu', # 百度
#    'ADSuyiSDKPlatforms/ks', # 快手(非内容版本，内容与非内容版本不可同时导入)
#    'ADSuyiSDKPlatforms/mtg', # Mobvista(汇量)
#    'ADSuyiSDKPlatforms/jad',     # 京媒
    
 # ab二选一
 # a.不需要gromore
#    'ADSuyiSDKPlatforms/bu', # 穿山甲(头条)
 # b.需要gromore
#    'ADSuyiSDKPlatforms/bu-without', # 穿山甲(头条)
#    'ADSuyiSDKPlatforms/gromore', # gromore
  ]
 # 以下为gromore的三方适配器，按需导入（优量汇已导入，无需额外导入）
  #pod 'CSJMKsAdapter',         '3.3.61.0.1'
  #pod 'CSJMBaiduAdapter',      '5.35.0'
  #pod 'CSJMMintegralAdapter',  '7.6.3.0'
  
  pod 'MJRefresh'

end
