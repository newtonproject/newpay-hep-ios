# NewPaySDK-iOS
iOS SDK for NewPay Integration


## Get Start

### CocoaPods

CocoaPods is the recommended way to add NewPaySDK to your project.

1. Add a pod entry for NewPaySDK to your Podfile: pod 'NewPaySDK-iOS'
2. Install the pod(s) by running pod install.
3. Include NewPaySDK wherever you need it with:
    - (Swift) import NewPaySDK_iOS 
    - (Objective-c) #import <NewPaySDK_iOS/NewPaySDK_iOS-Swift.h>
    
    

## Usage


#### Initiation

 ```
 /// Swift
 
 NewtonSDK(dappId: <#T##String#>, protocolVersion: <#T##String#>, protocolName: <#T##String#>, bundleSource: <#T##String#>, environment: <#T##Int#>, schemaProtocol: <#T##String#>)
 
 /// Objective-C
 
 [NewtonSDK alloc] initWithDappId:<#(NSString * _Nonnull)#> protocolVersion:<#(NSString * _Nonnull)#> protocolName:<#(NSString * _Nonnull)#> bundleSource:<#(NSString * _Nonnull)#> environment:<#(NSInteger)#> schemaProtocol:<#(NSString * _Nonnull)#>
 
 ```
 
 #### Login
 
 ```
 /// Swift
 
 authLogin(memo: <#T##String#>, signature: <#T##String#>, nonce: <#T##String#>, ts: <#T##String#>, uuid: <#T##String#>, completion: <#T##(String) -> Void#>, failure: <#T##(String) -> Void#>)
 
 /// Objective-C
 
 authLoginWithMemo:<#(NSString * _Nonnull)#> signature:<#(NSString * _Nonnull)#> signType:<#(NSString * _Nonnull)#> scope:<#(NSInteger)#> nonce:<#(NSString * _Nonnull)#> ts:<#(NSString * _Nonnull)#> uuid:<#(NSString * _Nonnull)#> completion:<#^(NSString * _Nonnull)completion#> failure:<#^(NSString * _Nonnull)failure#>
 
 ```
 
 #### Make Payment
 
 ```
 /// Swift
 pay(signature: <#T##String#>, description: <#T##String#>, priceCurrency: <#T##String#>, totalPrice: <#T##String#>, orderNumber: <#T##String#>, seller: <#T##String#>, customer: <#T##String#>, broker: <#T##String#>, nonce: <#T##String#>, ts: <#T##String#>, uuid: <#T##String#>, completion: <#T##(String) -> Void#>, failure: <#T##(String) -> Void#>)
 
 /// Objective-C
 payWithSignature:<#(NSString * _Nonnull)#> signType:<#(NSString * _Nonnull)#> description:<#(NSString * _Nonnull)#> priceCurrency:<#(NSString * _Nonnull)#> totalPrice:<#(NSString * _Nonnull)#> orderNumber:<#(NSString * _Nonnull)#> seller:<#(NSString * _Nonnull)#> customer:<#(NSString * _Nonnull)#> broker:<#(NSString * _Nonnull)#> nonce:<#(NSString * _Nonnull)#> ts:<#(NSString * _Nonnull)#> uuid:<#(NSString * _Nonnull)#> completion:<#^(NSString * _Nonnull)completion#> failure:<#^(NSString * _Nonnull)failure#>
 ```
 
 #### Proof Submit
 
 ```
 /// Swift
 placeOrder(signature: <#T##String#>, proofHash: <#T##String#>, nonce: <#T##String#>, ts: <#T##String#>, uuid: <#T##String#>, completion: <#T##(String) -> Void#>, failure: <#T##(String) -> Void#>)
 
 /// Objective-C
 placeOrderWithSignature:<#(NSString * _Nonnull)#> signType:<#(NSString * _Nonnull)#> proofHash:<#(NSString * _Nonnull)#> nonce:<#(NSString * _Nonnull)#> ts:<#(NSString * _Nonnull)#> uuid:<#(NSString * _Nonnull)#> completion:<#^(NSString * _Nonnull)completion#> failure:<#^(NSString * _Nonnull)failure#>
 ```
 
 
 ## License
 
 This code is distributed under the terms and conditions of the GPL-3.0 license.
