# TTImagePicker



### Installation

```
pod 'TTImagePicker'
```



and run `pod install`. It will install the most recent version of TTImagePicker.



### Usage

```
 [self tt_showAlbumWithPhoto:^(UIImage *photo) {
       self.avatorImageView = photo;
  } canclePick:^{
       NSLog(@"用户取消");
  }];

```

