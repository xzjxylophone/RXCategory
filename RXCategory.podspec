

Pod::Spec.new do |s|
  s.name     = "RXCategory"
  s.version  = "2.2"
  s.license  = "MIT"
  s.summary  = "RXCategory is a normal category"
  s.homepage = "https://github.com/xzjxylophone/RXCategory"
  s.author   = { 'Rush.D.Xzj' => 'xzjxylophoe@gmail.com' }
  s.social_media_url = "http://weibo.com/xzjxylophone"
  s.source   = { :git => 'https://github.com/xzjxylophone/RXCategory.git', :tag => "v#{s.version}" }
  s.description = %{
      RXCategory is a normal category.
  }
  s.source_files = 'RXCategory/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.platform = :ios, '5.0'
end






