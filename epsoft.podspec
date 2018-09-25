
Pod::Spec.new do |s|


s.name         = "epsoft"
s.version      = "1.0.2"
s.summary      = "epsoft component for ios by objective-c"

s.description  =<<-DESC
It is a component for ios epsoft project,written by Objective-C.
DESC
s.homepage     = "https://github.com/zhuguojun0022/epsoft/tree/master/EPComponent/Component"

s.license      = "MIT"

s.author       = { "zhuguojun" => "zhugj@epsoft.com.cn" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/zhuguojun0022/epsoft.git", :tag => s.version }

s.source_files  = "EPComponent/Component/**/*.{h,m}"
s.resource_bundles = {
'EPComponent' => ['EPComponent/Component/LocalImage/*.png']
}                                       #资源文件地址
s.requires_arc = true
s.dependency 'Masonry', '~> 0.6.2'
s.dependency 'SDWebImage', '~> 4.0'

end



