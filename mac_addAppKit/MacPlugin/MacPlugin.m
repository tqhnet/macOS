//
//  MacPlugin.m
//  MacPlugin
//
//  Created by xj_mac on 2021/10/26.
//

#import "MacPlugin.h"
#import <AppKit/AppKit.h>

@implementation MacPlugin

- (void)sayHello {
    NSLog(@"测试");
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"测试1";
    alert.informativeText = @"弹窗信息";//内容
    [alert addButtonWithTitle:@"确定"];//按钮所显示的文案
    [alert runModal];
}


- (NSObject *)getNSStatusBar {
    return [NSStatusBar systemStatusBar];
}

- (void)addStatusItem {
    //获取系统单例NSStatusBar对象
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    NSStatusItem *statusItem = [statusBar statusItemWithLength: NSSquareStatusItemLength];
//    self.statusItem = statusItem;
//    object =
    [statusItem setHighlightMode:YES];
    [statusItem setImage: [NSImage imageNamed:@"4322icon"]]; //设置图标，请注意尺寸
////    [statusItem setToolTip:@"这是一个 ToolTip"];
////    [statusItem.button setAction:@selector(statusButtonOnClick:)];


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
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"主标题";
    alert.informativeText = @"弹窗信息";//内容
    [alert addButtonWithTitle:@"确定"];//按钮所显示的文案
    [alert runModal];
}

- (void)load2{
    NSLog(@"load1 ---- ");
    [NSApp terminate:self];
}

// 读取这个没有问题可以读取外部参数，
- (void)openPanel {
//    NSURL *str = [NSURL fileURLWithPath:NSHomeDirectory()];
//    NSLog(@"%@",str);
    //[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil]
    NSOpenPanel *panel = [MacPlugin
                            openPanelWithTitleMessage:@"Choose File" // folder 顶部提示
                                                         setPrompt:@"OK"                      // 文件选择确认键 显示内容（一般NULL随系统）
                                                       chooseFiles:YES                        // 是否可以选择文件（如果为NO 则只可以选择文件夹）
                                                 multipleSelection:YES                        // 是否可以多选
                                                 chooseDirectories:YES                         // 是否可以选择文件夹
                                                 createDirectories:YES                        // 是否可以创建文件夹
                                                   andDirectoryURL:NULL                       // 默认打开路径（桌面、 下载、...）
                          AllowedFileTypes:@[] // 所能选择的文件类型
                            ];
      
      __block NSArray *chooseFiles;
      [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
          if (result == NSModalResponseOK) {
              chooseFiles = [panel URLs];
              NSLog(@"Click OK Choose files : %@",chooseFiles);
              NSData *data = [NSData dataWithContentsOfFile:chooseFiles[0]];
              NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"%@",str);
          }else if(result == NSModalResponseCancel)
              NSLog(@"Click cancle");
      }];
}

- (void)savePanel {
    //[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil]
    NSSavePanel *panel  =  [MacPlugin savePanelWithTitleMessage:@"Save File"
                                      setPrompt:NULL
                               setTitle:@"Save File Panel"
                                 nameFiledValue:@"Image"
                              createDirectories:YES
                         bSelectHiddenExtension:YES
                                andDirectoryURL:NULL
                               AllowedFileTypes:[NSArray arrayWithObjects:@"png",@"jpg",@"bmp", nil]];
        
       NSString *savePath = [MacPlugin getSavePanelChooseFiles:panel];
       NSLog(@"Save Path : %@",savePath);
//    nshom
    NSImage *image = [NSImage imageNamed:@"4322icon1"];
    NSData *data =  [image TIFFRepresentation];
    NSLog(@"%@",data);
//    NSURL *path = [NSURL fileURLWithPath:NSHomeDirectory()];
//    bool success =[data writeToFile:savePath atomically:YES];
////    bool success = [@"www" writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    if (success) {
//        NSLog(@"成功");
//    }else {
//        NSLog(@"失败");
//    }
    

}

#pragma mark - tool

+(NSOpenPanel *)openPanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                              chooseFiles:(BOOL)bChooseFiles
                        multipleSelection:(BOOL)bSelection
                        chooseDirectories:(BOOL)bChooseDirc
                        createDirectories:(BOOL)bCreateDirc
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setPrompt:prompt];     // 设置默认选中按钮的显示（OK 、打开，Open ...）
    [panel setMessage: ttMessage];    // 设置面板上的提示信息
    [panel setCanChooseDirectories : bChooseDirc]; // 是否可以选择文件夹
    [panel setCanCreateDirectories : bCreateDirc]; // 是否可以创建文件夹
    [panel setCanChooseFiles : bChooseFiles];      // 是否可以选择文件
    [panel setAllowsMultipleSelection : bSelection]; // 是否可以多选
    [panel setAllowedFileTypes : fileTypes];        // 所能打开文件的后缀
    
    [panel setDirectoryURL:dirURL];                    // 打开的文件路径
    
    return panel;
}



+(NSSavePanel *)savePanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                                 setTitle:(NSString *)title
                           nameFiledValue:(NSString *)fileName
                        createDirectories:(BOOL)bCreateDirc
                   bSelectHiddenExtension:(BOOL)bSelectHiddenExtension
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
{
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setMessage:ttMessage];
    [panel setPrompt:prompt];
    [panel setAllowedFileTypes:fileTypes];
    [panel setCanCreateDirectories : bCreateDirc];
    [panel setCanSelectHiddenExtension : bSelectHiddenExtension];
    [panel setTitle:title];
    [panel setNameFieldStringValue:fileName];
    [panel setDirectoryURL:dirURL];
    
    return panel;
}


+(NSString *)getSavePanelChooseFiles:(NSSavePanel *)panel
{
    NSString *filePath = @"";
    NSInteger result = [panel runModal];
    if (result == NSModalResponseOK)
    {
        filePath = [[panel URL] absoluteString];  //[panel filename] 注意两个路径的格式
        NSLog(@"filePath : %@",filePath);
        
    }else
    {
        NSLog(@"Choose Cancle! ");
    }
    return filePath;
}


@end
