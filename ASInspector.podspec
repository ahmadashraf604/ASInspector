Pod::Spec.new do |s|

    s.name         = "ASInspector"
    s.version      = "0.1.0"
    s.summary      = "Network Logger and Console Logger"
    s.description  = <<-DESC 
    ASInspector is simple and extensible logger. It makes easy to log network request and response on file, Xcode console or send log to servers. It provides user friendly UI for debugging and testing purpose. 
                     DESC
  
    s.homepage     = "https://github.com/ahmadashraf604/ASInspector"
    s.screenshots  = "https://github.com/ahmadashraf604/ASInspector/blob/main/ASInspector.png"
  
    s.license      = { :type => "MIT", :file => "LICENSE.md" }
  
    s.author             = { "Ahmed Ashraf" => "ahmadashraf604@gmail.com" }
    s.social_media_url   = "https://www.linkedin.com/in/ahmadashraf604/"
  
    s.platform     = :ios
    s.swift_version = '5.0'
    s.ios.deployment_target = "9.0"
    s.source       = { :git => "https://github.com/ahmadashraf604/ASInspector.git", :tag => "v#{s.version}" }
  
    s.source_files  = "ASInspector/**/*.swift"
    s.resources = "ASInspector/ASInspector/InspectorUI/**/*.{xcassets,storyboard,xib}"
  
    s.requires_arc = true
  
    s.frameworks = 'WebKit'
  end
  