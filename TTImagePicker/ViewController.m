//
//  ViewController.m
//  TTImagePicker
//
//  Created by dianda on 2017/4/28.
//  Copyright © 2017年 taitanxiami. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+TTImagePicker.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)takePhoto:(id)sender {
    
    [self tt_showAlbumWithPhoto:^(UIImage *photo) {
        self.imageView.image = photo;
    } canclePick:^{
        
        NSLog(@"取消");
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
