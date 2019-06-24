
Pod::Spec.new do |spec|
  spec.name          = "NewPaySDK-iOS"
  spec.version       = "1.0.1"
  spec.summary       = "NewPay SDK for ios"
  spec.description   = "NewPay SDK for login, payment and proof submission"
  spec.homepage      = "https://github.com/newtonproject/NewPaySDK-iOS"
  spec.license       = { :type => "GPLv3", :file => "LICENSE" } 
  spec.author        = { "newtonproject" => "newton-app@newtonproject.org" }
  spec.platform      = :ios, "8.0"
  spec.source        = { :git => "https://github.com/newtonproject/NewPaySDK-iOS.git", :tag => "1.0.1" }
  spec.source_files  = "NewtonSDK", "*.{h,swift}"
  spec.swift_version = '4.0'
  spec.requires_arc  = true
end
