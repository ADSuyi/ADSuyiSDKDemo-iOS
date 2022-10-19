# Uncomment the next line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'

target 'ADSuyiSDKDemo-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks

  # Pods for ADSuyiSDKDemo-iOS
  pod 'ADSuyiSDK', '~> 3.6.6.08248'
  pod 'ADSuyiSDK', '~> 3.6.6.08248', :subspecs => [
    'ADSuyiSDKPlatforms/tianmu', # 天目  #必选
    'ADSuyiSDKPlatforms/bu', # 穿山甲(头条)
    'ADSuyiSDKPlatforms/gdt', # 优量汇(广点通）
    'ADSuyiSDKPlatforms/baidu', # 百度
    'ADSuyiSDKPlatforms/ks', # 快手(非内容版本，内容与非内容版本不可同时导入)
    'ADSuyiSDKPlatforms/mtg',     # Mobvista(汇量)
    #'ADSuyiSDKPlatforms/gromore', # gromore
    'ADSuyiSDKPlatforms/inmobi' # Inmobi
  ]
  pod 'MJRefresh'
  
  
  # 模拟器无法运行时，可添加该代码 pod install
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings[“EXCLUDED_ARCHS[SDK=iphonesimulator*]”] = “arm64”
    end
  end

end
