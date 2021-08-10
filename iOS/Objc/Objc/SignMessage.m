//
//  SignMessage.m
//  Objc
//
//  Created by Shilei Mao on 04/08/2021.
//

#import "SignMessage.h"
#import <HorizonFintexSDK/HorizonFintexSDK.h>

@interface SignMessage ()
@property (strong, nonatomic) id<EthereumOperator> ethOperator;
@end

@implementation SignMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ethOperator = [EthereumCreator createOperatorWithAttachedView:self.view];
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
    NSString *keystoreStr = [[self.tfKeystore text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([self isEmptyStr:keystoreStr]) {
        [self showMessageWithTitle:@"Error" message:@"Please enter keystore"];
        return;
    }
    
    NSString *pwdStr = [self.tfPwd text];
    if ([self isEmptyStr:pwdStr]) {
        
        [self showMessageWithTitle:@"Error" message:@"Please enter password"];
        return;
    }
    
    NSString *messageToSign = [self.tfMessage text];
    if ([self isEmptyStr:messageToSign]) {
        [self showMessageWithTitle:@"Error" message:@"Please enter message"];
        return;
    }
    
    NSString *contractAddress = [[self.tfContractAddr text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([self isEmptyStr:contractAddress]) {
        [self showMessageWithTitle:@"Error" message:@"Please enter contract addr"];
        return;
    }
    
    NSString  * _Nullable keystore = [[EthereumKeystore alloc] initWithKeystoreJSON:keystoreStr];
    if (keystore == nil) {
        [self showMessageWithTitle:@"Error" message:@"You've entered invalid keystore, please try again"];
        return;
    }
    
    [self showProgress];
    [[self ethOperator] signMessageWithContractAddr:contractAddress keystore:keystore password:pwdStr signOriginal:messageToSign completion:^(NSString * _Nullable result, NSError * _Nullable error) {
        [self dismissProgress];
        
        if (error != nil) {
            [self showMessageWithTitle:@"Error" message:[error description]];
            return;
        }
        
        [self showMessageWithTitle:@"Signed message" message:result];
    }];
    
}

- (void)showMessageWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertView = [UIAlertController
                                    alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
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
