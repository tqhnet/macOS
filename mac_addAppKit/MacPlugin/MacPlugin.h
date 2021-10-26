//
//  MacPlugin.h
//  MacPlugin
//
//  Created by xj_mac on 2021/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MacPluginDelegate <NSObject>

- (void)sayHello;

@end

@interface MacPlugin : NSObject

@property (nonatomic,weak)id<MacPluginDelegate>delegate;

- (void)sayHello;
- (void)addStatusItem;
- (NSObject *)getNSStatusBar;

- (void)openPanel;
- (void)savePanel;
@end

NS_ASSUME_NONNULL_END
