//
//  SignMessage.h
//  Objc
//
//  Created by Shilei Mao on 04/08/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignMessage : UIViewController
@property (weak, nonatomic) IBOutlet UITextField * tfKeystore;
@property (weak, nonatomic) IBOutlet UITextField * tfPwd;
@property (weak, nonatomic) IBOutlet UITextField * tfMessage;
@property (weak, nonatomic) IBOutlet UITextField * tfContractAddr;
@property (weak, nonatomic) IBOutlet UIButton * signMessage;
@property (weak, nonatomic) IBOutlet UILabel * lbSignedMessage;
@end

NS_ASSUME_NONNULL_END
