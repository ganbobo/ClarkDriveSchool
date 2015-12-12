//
//  PersonalDataController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "PersonalDataController.h"

#import "EditDataController.h"
#import "AFNManager.h"
#import "ImageUtils.h"
#import "JSONKit.h"

#import <UIImageView+AFNetworking.h>

@interface PersonalDataController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate> {
    NSArray *_dataSource;
    __weak IBOutlet UITableView *_tableView;
    
    UIImageView *_avatarImage;
}

@end

@implementation PersonalDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _dataSource = @[@[@"我的头像"], @[@"用户名", @"手机", @"姓名", @"身份证"], @[@"设置"]];
    [self loadNav];
    [self loadAvatarView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];// 刷新数据
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"个人中心"];
}

- (void)loadAvatarView {
    _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _avatarImage.layer.cornerRadius = 25;
    _avatarImage.layer.masksToBounds = YES;
    _avatarImage.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _avatarImage.layer.borderWidth = 2;
    _avatarImage.image = [UIImage imageNamed:@"default_user_avatar"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = _dataSource[section];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell" forIndexPath:indexPath];
    NSArray *list = _dataSource[indexPath.section];
    cell.textLabel.text = list[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = nil;
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = @"";
        cell.accessoryView = _avatarImage;
        [_avatarImage setImageWithURL:getImageUrl(getUser().resource_url) placeholderImage:[UIImage imageNamed:@"default_user_avatar"]];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else if (indexPath.section == 2) {
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = [self getPhoneNum:getUser().login_name];
                break;
            case 1:
                cell.detailTextLabel.text = [self getPhoneNum:getUser().login_name];
                break;
            case 2: {
                cell.detailTextLabel.text = getUser().cn_name;
                if ([getUser().cn_name isEqualToString:@"未填写"]) {
                    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                }
            }
                break;
            case 3: {
                cell.detailTextLabel.text = getUser().identification;
                if ([getUser().identification isEqualToString:@"未填写"]) {
                    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                }
            }
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"头像上传" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册获取", nil];
        [actionSheet showInView:self.view];
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
                
            case 2: {
                if ([getUser().cn_name isEqualToString:@"未填写"]) {
                    [self performSegueWithIdentifier:@"EditData" sender:@(YES)];
                }
            }
                break;
            case 3: {
                if ([getUser().identification isEqualToString:@"未填写"]) {
                    [self performSegueWithIdentifier:@"EditData" sender:@(NO)];
                }
            }
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"Setting" sender:indexPath];
    }
}

#pragma - mark 界面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditData"]) {
        BOOL isEditName = [(NSNumber *)sender boolValue];
        EditDataController *controller = segue.destinationViewController;
        controller.isEditName = isEditName;
    }
}

#pragma - mark 隐藏手机号中间四位

- (NSString *)getPhoneNum:(NSString *)phoneNum {
    NSString *tel = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return tel;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {// 拍照
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"设备不支持摄像头功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                return;
            }
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];//进入照相界面
        }
            break;
        case 1: {// 相册
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = YES;
            [self presentViewController:pickerImage animated:YES completion:^{
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            }];
        }
            break;
        default:
            break;
    }

}

#pragma - mark UIImagePickerControllerDelegate 代理


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *lastImage = [ImageUtils imageCompressForSize:[info objectForKey:UIImagePickerControllerEditedImage] targetSize:CGSizeMake(320, 320)];
        NSData *data = UIImageJPEGRepresentation(lastImage, 0.5);
        // 上传图片
        [self updateUserInfo:data];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

#pragma - mark 修改用户数据

 - (void)updateUserInfo:(NSData *)aravatar {
     NSDictionary *param = @{@"userId": hasUser()? getUser().id : @"123",
                             @"isType": @"1"
                             };
     [self showWaitView:@"正在上传头像"];
     [[AFNManager manager] postImageServer:UPDATE_USER_INFO_SERVER imageData:@[aravatar] parameters:@{PARS_KEY: [param JSONString]} callBack:^(NSDictionary *response, NSString *netErrorMessage) {
         
         if (netErrorMessage) {
             [self hiddenWaitViewWithTip:netErrorMessage type:MessageWarning];
         } else {
             NSString *responseCode = getResponseCodeFromDic(response);
             if ([responseCode isEqualToString:ResponseCodeSuccess]) {
                 NSString *url = response[@"data"];
                 
                 UserInfo *info = getUser();
                 info.resource_url = url;
                 [info updatetoDb];
                 [self hiddenWaitViewWithTip:@"上传成功" type:MessageSuccess];
                 [_tableView reloadData];
             } else {
                 NSString *message = response[RESPONSE_MESSAGE];
                 [self hiddenWaitViewWithTip:message type:MessageFailed];
             }
         }
     }];

 }

@end
