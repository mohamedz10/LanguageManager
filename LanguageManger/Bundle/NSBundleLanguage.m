//
//  NSBundle+Language.m
//  ImmediateLanguageSwitchSwift
//
//  Created by Manuel Meyer on 07.08.15.
//
//

#import "NSBundleLanguage.h"
#import <objc/runtime.h>

static const char associatedLanguageBundle=0;

@interface PrivateBundle : NSBundle

@end

@implementation PrivateBundle

NSString * currentLanguage;

-(NSString*)localizedStringForKey:(NSString *)key
                            value:(NSString *)value
                            table:(NSString *)tableName {
    NSBundle* bundle=objc_getAssociatedObject(self, &associatedLanguageBundle);
    return bundle ? [bundle localizedStringForKey:key
                                            value:value
                                            table:tableName] : [super localizedStringForKey:key
                                                                                      value:value
                                                                                      table:tableName];
}
@end

@implementation NSBundle (Language)
+(void)setLanguage:(NSString*)language{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle],[PrivateBundle class]);
    });
    
    objc_setAssociatedObject([NSBundle mainBundle], &associatedLanguageBundle, language ?
                             [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:language, nil]
                                              forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    currentLanguage  = language;
}


+(NSString *)getCurrentLanguage {
    return currentLanguage;
}

@end
