# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Workout Tracker' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Workout Tracker
  pod 'RealmSwift'
  pod 'Charts', '3.0.2'
  pod 'Alamofire', '4.4.0'
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'

  target 'Workout TrackerTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RealmSwift'
    pod 'Charts', '3.0.2'
    pod 'Alamofire', '4.4.0'
    pod 'ObjectMapper'
    pod 'AlamofireObjectMapper'
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
