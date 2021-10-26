//
//  AppDelegate.m
//  mac_addAppKit
//
//  Created by xj_mac on 2021/10/26.
//

#import "AppDelegate.h"
#import "Plugin.h"
#import "MacPlugin.h"
#import <AppKit/AppKit.h>

// 参考：https://blog.csdn.net/weixin_26737625/article/details/108515514
// 文件操作：https://blog.csdn.net/auspark/article/details/106633737
// 需要添加权限
// 最后发现实用性不行弃坑

@interface AppDelegate ()

@property (nonatomic,strong) MacPlugin *macPlugin;
@property (nonatomic,strong) NSObject *statusItem; //必须应用、且强引用，否则不会显示。
//@property
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self loadMacPlugin];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"开始");
        [self.macPlugin savePanel];
//        [self.macPlugin addStatusItem];
       
    });
    return YES;
}

- (void)loadMacPlugin {
    NSString *bundleFile = @"MacPlugin.bundle";
    NSURL *bundleURL = [[[NSBundle mainBundle]builtInPlugInsURL]URLByAppendingPathComponent:bundleFile];
    if (!bundleFile) {
        NSLog(@"没有加载mac插件");
        return;
    }
    NSLog(@"加载了APPKit插件");
    NSBundle *pluginBundle = [NSBundle bundleWithURL:bundleURL];
    NSString *className = @"MacPlugin";
    Class test = [pluginBundle classNamed:className];
    NSLog(@"%@",test);
    self.macPlugin = [[test alloc]init];
//    self.statusItem = [self.macPlugin getNSStatusBar];
    
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
