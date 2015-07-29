Pod::Spec.new do |s|

  s.name         = "AsyncOperation"
  s.version      = "1.0.0"
  s.summary      = "A hassle-free implementation of asynchronous NSOperations/NSBlockOperations."

  s.description  = <<-DESC
                   AsyncOperation aims to ease the pain commonly encountered when having to subclass NSOperation for async tasks.
                   DESC

  s.homepage     = "https://github.com/regexident/AsyncOperation"
  s.license      = { :type => 'BSD-3', :file => 'LICENSE' }
  s.author       = { "Vincent Esche" => "regexident@gmail.com" }
  s.source       = { :git => "https://github.com/regexident/AsyncOperation.git", :tag => '1.0.0' }
  s.source_files = "AsyncOperation/Classes/*.{swift,h,m}"
  # s.public_header_files = "AsyncOperation/*.h"
  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"
  
end
