#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
import GoogleMaps

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"AIzaSyDaMXIHnvhx8fufYG6da9gEAOs1_Gwl8d8"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
