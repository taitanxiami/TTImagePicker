Pod::Spec.new do |s|
s.name         = "TTImagePicker"
s.version      = "1.0.0"
s.summary      = "一行代码集成拍照和相册选取"
s.homepage     = "https://github.com/taitanxiami/TTImagePicker"
s.license      = "MIT"
s.author       = { "taitanxiami" => "taitanxiami@gmail.com" }
s.source       = { :git => "https://github.com/taitanxiami/TTImagePicker.git", :tag => "1.0.0" }
s.platform     = :ios, '8.0'
s.source_files = 'TTImagePicker/**/*'
s.requires_arc = true
end