//
//  SignMessage.m
//  Objc
//
//  Created by Shilei Mao on 04/08/2021.
//

#import "SignMessage.h"
#import <HorizonFintexSDK/HorizonFintexSDK.h>

@interface SignMessage ()
@property (strong, nonatomic) HGEthereumOperator *ethOperator;
@end

@implementation SignMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JSWebview *webview = [[JSWebview alloc] initWithHandlers: nil];
    
    self.ethOperator = [[HGEthereumOperator alloc] initWithJsEvaluator:webview attachedView:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btSignMessageTapped:(id)sender {
    NSString *keystoreStr = [self.tfKeystore text];
    if ([self isEmptyStr:keystoreStr]) {
        [self showErrorWithMessage:@"Please enter keystore"];
        return;
    }
    
    NSString *pwdStr = [self.tfPwd text];
    if ([self isEmptyStr:pwdStr]) {
        [self showErrorWithMessage:@"Please enter password"];
        return;
    }
    
    NSString *messageToSign = [self.tfMessage text];
    if ([self isEmptyStr:messageToSign]) {
        [self showErrorWithMessage:@"Please enter message"];
        return;
    }
    
    NSString *contractAddress = [self.tfContractAddr text];
    if ([self isEmptyStr:contractAddress]) {
        [self showErrorWithMessage:@"Please enter contract addr"];
        return;
    }
    
    NSString  * _Nullable keystore = [[EthereumKeystore alloc] initWithJsonStr:keystoreStr];
    if (keystore == nil) {
        [self showErrorWithMessage:@"You've entered invalid keystore, please try again"];
        return;
    }
    
    [self showProgress];
    [[self ethOperator] signMessageWithContractAddr:contractAddress keystore:keystore password:pwdStr signOriginal:messageToSign completion:^(NSString * _Nullable result, NSError * _Nullable error) {
        [self dismissProgress];
        
        if (error != nil) {
            [self showErrorWithMessage:[error description]];
            return;
        }
        
        [self.lbSignedMessage setText:result];
    }];
    
}

- (void)showErrorWithMessage:(NSString *)message {
    UIAlertController *alertView = [UIAlertController
                                    alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    
    [alertView addAction:cancelAction];
    
    [self presentViewController:alertView animated:true completion:nil];
}

- (void)showProgress {
    UIViewController *progressView = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgressView"];
    [progressView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [progressView setModalPresentationStyle:UIModalPresentationOverFullScreen];
    
    [self presentViewController:progressView animated:true completion:nil];
}

- (void)dismissProgress {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)isEmptyStr: (NSString *)string {
    if (string == nil || [string length] == 0) {
        return true;
    }
    return false;
}
@end
