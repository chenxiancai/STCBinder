Pod::Spec.new do |s|
  s.name         = 'STCBinder'
  s.summary      = 'A lightweight architecture than reactivecocoa , a simple and easy way to write code in MVVM pattern。'
  s.version      = '1.1.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'chenxiancai' => 'chenxiancai@hotmail.com' }
  s.homepage     = 'https://github.com/chenxiancai/STCBinder'

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'

  s.source       = { :git => 'https://github.com/chenxiancai/STCBinder.git', :tag => s.version }
  
  s.source_files = "STCBinder/STCBinder/*.{h,m,c}"
  s.requires_arc = true
  s.frameworks = 'Foundation'

end
