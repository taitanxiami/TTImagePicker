//
//  UIViewController+TTImagePicker.m
//  TTImagePicker
//
//  Created by dianda on 2017/4/28.
//  Copyright © 2017年 taitanxiami. All rights reserved.
//

#import "UIViewController+TTImagePicker.h"
#import <objc/runtime.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>

static const void *tt_blockKey = &tt_blockKey;
static const void *tt_canEditKey = &tt_canEditKey;
static const void *tt_canclePickerBlockkKey = &tt_canclePickerBlockkKey;

@interface UIViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (copy, nonatomic) tt_photoBlock photoBlock;
@property (copy, nonatomic) tt_canclePickerBlock canclePickerBlock;
@property (assign, nonatomic) BOOL canEdit;


@end
@implementation UIViewController (TTImagePicker)


- (void)setPhotoBlock:(tt_photoBlock)photoBlock {
    objc_setAssociatedObject(self, &tt_blockKey, photoBlock, OBJC_ASSOCIATION_COPY);
}

- (tt_photoBlock)photoBlock {
    return objc_getAssociatedObject(self, &tt_blockKey);
}

- (void)setCanclePickerBlock:(tt_canclePickerBlock)canclePickerBlock {
    objc_setAssociatedObject(self, &tt_canclePickerBlockkKey, canclePickerBlock, OBJC_ASSOCIATION_COPY);
}

- (tt_canclePickerBlock)canclePickerBlock {
    return objc_getAssociatedObject(self, &tt_canclePickerBlockkKey);
}

- (void)setCanEdit:(BOOL)canEdit {
    objc_setAssociatedObject(self, &tt_canEditKey, @(canEdit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canEdit {
    return [objc_getAssociatedObject(self, &tt_canEditKey) boolValue];
}


// init method
- (void)tt_showAlbumWithPhoto:(tt_photoBlock )photoBlock  canclePick:(tt_canclePickerBlock)canclePciker{
    [self tt_showAlbumWithPhoto:photoBlock canclePick:canclePciker canEdit:YES];
}

- (void)tt_showAlbumWithPhoto:(tt_photoBlock )photoBlock canclePick:(tt_canclePickerBlock)canclePciker canEdit:(BOOL)edit {
    self.canEdit = edit;
    self.photoBlock = photoBlock;
    self.canclePickerBlock = canclePciker;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            if([self camera_authorization]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                picker.allowsEditing = edit;
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:nil];
                
            }else {
                [self showMessage:@"请在系统设置中开启该应用相机服务\n(设置->隐私->相机->开启)" title:@"相机权限未开启"];
                
            }
        }else {
            
            [self showMessage:@"不支持相机" title:@"提示"];
        }
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([self photo_authorization]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.allowsEditing = self.canEdit;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];

        }else {
            [self showMessage:@"请在系统设置中开启该应用相册服务\n(设置->隐私->相册->开启)" title:@"相册权限未开启"];
        }
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:cancleAction];

    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *photo = nil;
    if(picker.allowsEditing) {
        
        photo = [info objectForKey:UIImagePickerControllerEditedImage];
    }else {
        photo = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    
    if (self.photoBlock) {
        self.photoBlock(photo);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    if (self.canclePickerBlock) {
        self.canclePickerBlock();
    }
}

/**
 获取相册权限

 @return 是否可用
 */
- (BOOL)photo_authorization {
    
    PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
    if (author == PHAuthorizationStatusRestricted || author == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}
/**
 获取相机权限
 
 @return 是否可用
 */

- (BOOL)camera_authorization {
    
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (author == AVAuthorizationStatusRestricted || author == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

/**
 错误提示

 @param msg 错误信息
 @param title 提示标题
 */
- (void)showMessage:(NSString *)msg title:(NSString *)title {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title
                                                                         message:msg
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
           }];
      [actionSheet addAction:photoAction];
    [self presentViewController:actionSheet animated:YES completion:nil];

}
@end
