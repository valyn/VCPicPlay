//
//  VCHeader.h
//  
//
//  Created by Valyn on 2018/4/12.
//


#ifndef VCHeader_h
#define VCHeader_h


typedef void (^EventBlock)();

#define VCImageBlueColor ColorWithRGBA(30, 124, 230, 1)

#ifdef DEBUG
#define VCLog(fmt,...); NSLog((fmt),__VA_ARGS__);
#else
#define VCLog(...);
#endif


#define VCEncode(str) [(str) dataUsingEncoding:NSUTF8StringEncoding]


#define AppUsedFirstTimeKey @"AppUsedFirstTime"
#define AppUsedFirstTimeCount [[[NSUserDefaults standardUserDefaults] objectForKey:AppUsedFirstTimeKey] integerValue]


#define ColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]


#define WeakObj(obj) autoreleasepool{} __weak typeof(obj) obj##Weak = obj;


#define Half(result) ((result) * 0.5)


#define isiPhone \
({\
    BOOL result = NO;\
    UIDevice *device = [UIDevice currentDevice];\
    NSString *model = device.model;\
    if([model isEqualToString:@"iPhone"]) {\
        result = YES;\
    }\
    (result);\
}) \

#define isiPad \
({\
    BOOL result = NO;\
    UIDevice *device = [UIDevice currentDevice];\
    NSString *model = device.model;\
    if([model isEqualToString:@"iPad"]) {\
        result = YES;\
    }\
    (result);\
}) \


/** Macro about Device Screen Size */
#define isScreenSize(w, h) \
({\
    BOOL result = NO;\
    if (([UIScreen mainScreen].bounds.size.width == w && [UIScreen mainScreen].bounds.size.height == h) || ([UIScreen mainScreen].bounds.size.width == h && [UIScreen mainScreen].bounds.size.height == w)) {\
        result = YES;\
    }\
    (result);\
})\

#define isiPhoneX isScreenSize(812, 375)
#define isiPhonePlus  isScreenSize(736, 414)

#define isiPad_9_7 isScreenSize(1024, 768)
#define isiPadPro_10_9 isScreenSize(1112, 834)
#define isiPadPro_12_9 isScreenSize(1366, 1024)

#define SafeAreaStatusBarHeight (isiPhoneX ? 44 : 20)
#define SafeAreaTopHeight (isiPhoneX ? 88 : 64)
#define SafeAreaBottomHeight (isiPhoneX ? 34 : 0)


#define VCViewW self.view.frame.size.width
#define VCViewH self.view.frame.size.height






#endif /* VCHeader_h */
