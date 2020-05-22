
Pod::Spec.new do |spec|
  spec.name          = "NewPaySDK-iOS"
  spec.version       = "1.1.2"
  spec.summary       = "NewPay SDK for ios"
  spec.description   = "NewPay SDK for login, payment, proof submission, sign message and sign transaction"
  spec.homepage      = "https://github.com/newtonproject/newpay-hep-ios"
  spec.license       = { :type => "GPLv3", :file => "LICENSE" } 
  spec.author        = { "newtonproject" => "newton-app@newtonproject.org" }
  spec.platform      = :ios, "8.0"
  spec.source        = { :git => "https://github.com/newtonproject/newpay-hep-ios.git", :tag => "1.1.2" }
  spec.source_files  = "NewtonSDK", "*.{h,swift}"
  spec.swift_version = '4.0'
  spec.requires_arc  = true
end
