Pod::Spec.new do |s|
s.name = "TheOldReader"
s.version = "1.0.0"
s.summary = 'TheOldReader API'
s.homepage = "https://github.com/wangdengwu/TheOldReader"
s.license = 'MIT'
s.author = {'王登武' => 'dengwu.wang@gmail.com','高宇' => '370802756@qq.com'}
s.source = { :git => 'https://github.com/wangdengwu/TheOldReader.git' }
s.platform = :ios, '7.0'
s.ios.deployment_target = '7.0'
s.requires_arc = true
s.source_files = 'TheOldReader/**/*.{h,m}'
s.resources = "Resources/*"
s.public_header_files = "TheOldReader/**/*.h"
s.framework = 'QuartzCore'
s.dependency 'ASIHTTPRequest', '~> 1.8.1'
s.header_mappings_dir = 'TheOldReader'
end
