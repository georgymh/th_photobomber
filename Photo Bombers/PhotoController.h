//
//  PhotoController.h
//  Photo Bombers
//
//  Created by Georgy Marrero on 1/19/15.
//  Copyright (c) 2015 Georgy Marrero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

+ (void)avatarForPhoto:(NSDictionary *)photo completion:(void(^)(UIImage *image))completion;

@end