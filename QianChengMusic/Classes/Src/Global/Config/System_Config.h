//
//  System_Config.h
//  QianChengMusic
//
//  Created by Jn_Kindle on 2018/9/13.
//  Copyright © 2018年 JnKindle. All rights reserved.
//

#ifndef System_Config_h
#define System_Config_h


//APP Version
#define JN_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//UUID
#define JN_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//打印相关
#ifdef DEBUG
#define JNLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JNLog(...)
#endif

//循环引用
#define JNWeakSelf __weak typeof(self) weakSelf = self;

#endif /* System_Config_h */
