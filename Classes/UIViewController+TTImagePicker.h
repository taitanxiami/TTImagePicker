//
//  UIViewController+TTImagePicker.h
//  TTImagePicker
//
//  Created by dianda on 2017/4/28.
//  Copyright © 2017年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tt_photoBlock)(UIImage *photo);
typedef void(^tt_canclePickerBlock)(void);

@interface UIViewController (TTImagePicker)

- (void)tt_showAlbumWithPhoto:(tt_photoBlock)photoBlock canclePick:(tt_canclePickerBlock)canclePciker;
- (void)tt_showAlbumWithPhoto:(tt_photoBlock)photoBlock canclePick:(tt_canclePickerBlock)canclePciker canEdit:(BOOL)edit;

@end
