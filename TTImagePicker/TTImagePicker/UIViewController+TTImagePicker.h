//
//  UIViewController+TTImagePicker.h
//  TTImagePicker
//
//  Created by dianda on 2017/4/28.
//  Copyright © 2017年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tt_photoBlock)(UIImage *photo);

@interface UIViewController (TTImagePicker)




- (void)showAlbumWithPhoto:(tt_photoBlock)photoBlock;
- (void)showAlbumWithPhoto:(tt_photoBlock)photoBlock canEdit:(BOOL)edit;

@end
