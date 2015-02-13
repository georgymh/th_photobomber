//
//  PhotoCell.m
//  Photo Bombers
//
//  Created by Georgy Marrero on 1/19/15.
//  Copyright (c) 2015 Georgy Marrero. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoController.h"

@implementation PhotoCell

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    [PhotoController imageForPhoto:_photo size:@"thumbnail" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
		self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(like:)];
        longPress.minimumPressDuration = 1.0f;
        [self addGestureRecognizer:longPress];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

- (void)like:(id)sender {
    //setting up the sessions, urls, request, and tasks
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    if ( longPress.state == UIGestureRecognizerStateEnded) {
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
        NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], accessToken];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showLikeCompletion];
            });
        }];
        [task resume];
    }
}

- (void)showLikeCompletion {
    //create the alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Liked!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    
    //the alert dissappears after 1 second
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

@end