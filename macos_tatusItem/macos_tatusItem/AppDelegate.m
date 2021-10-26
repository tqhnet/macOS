//
//  AppDelegate.m
//  macos_tatusItem
//
//  Created by xj_mac on 2021/10/26.
//

#import "AppDelegate.h"
#import "FirstViewController.h"

@interface AppDelegate ()

@property (nonatomic,strong) NSStatusItem *statusItem; //必须应用、且强引用，否则不会显示。
@property (nonatomic,strong) NSPopover *firstPopover;
@property (nonatomic,strong) FirstViewController * firstVC;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self addStatusItem];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)addStatusItem {
    //获取系统单例NSStatusBar对象
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    NSStatusItem *statusItem = [statusBar statusItemWithLength: NSSquareStatusItemLength];
    self.statusItem = statusItem;
    [statusItem setHighlightMode:YES];
    [statusItem setImage: [NSImage imageNamed:@"4322icon"]]; //设置图标，请注意尺寸
    [statusItem setToolTip:@"这是一个 ToolTip"];
    [statusItem.button setAction:@selector(statusButtonOnClick:)];
    
    
    // 添加了菜单就不会弹出控制器
    NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@"Load_TEXT"];
    [subMenu addItemWithTitle:@"About Cisco AnyConnect"action:@selector(load1) keyEquivalent:@""];
    [subMenu addItemWithTitle:@"Exit"action:@selector(load2) keyEquivalent:@""];
    statusItem.menu = subMenu;
    
    
//    // 自定义图标样式，可以添加消息数等
//    NSView *customerView = [[NSView alloc]initWithFrame:NSMakeRect(0, 0, 30, 5)];
//    customerView.wantsLayer = YES;
//    customerView.layer.backgroundColor = [NSColor redColor].CGColor;
//    [statusItem setView: customerView];

}

- (void)load1{
    NSLog(@"load1 ---- ");
}

- (void)load2{
    NSLog(@"load1 ---- ");
    [NSApp terminate:self];
}

//- (void)statusOnClick:(NSStatusItem *)item{
//
//    NSLog(@"statusOnClick ----- ");
//}

- (void)statusButtonOnClick:(NSButton *)btn{
    
    NSLog(@"statusButtonOnClick ----- ");
    [self.firstPopover showRelativeToRect:[btn bounds] ofView:btn preferredEdge:NSRectEdgeMaxY];
}

#pragma mark - layz

- (NSPopover *)firstPopover
{
    if(!_firstPopover)
    {
        _firstPopover=[[NSPopover alloc]init];
        _firstPopover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
        _firstPopover.contentViewController = self.firstVC;
        _firstPopover.behavior = NSPopoverBehaviorTransient;
        
    }
    return _firstPopover;
}

- (FirstViewController *)firstVC
{
    if(!_firstVC)
    {
        _firstVC=[[FirstViewController alloc]init];
    }
    return _firstVC;
}

@end
