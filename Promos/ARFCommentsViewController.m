//
//  ARFCommentsViewController.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/28/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommentsViewController.h"
#import "ARFConstants.h"
#import "ARFCommentsCell.h"
#import "ARFCommentsViewController+UIKeyboard.h"

#import <MBProgressHUD/MBProgressHUD.h>

static NSString* const kCommentCellIdentifier        = @"CommentCell";

@interface ARFCommentsViewController ()


@property (weak, nonatomic) IBOutlet UITextField *txtComment;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;


@property (nonatomic, strong) PFObject *promoObject;
@property (nonatomic, strong) NSMutableArray *commentsArray;

@end

@implementation ARFCommentsViewController


-(id) initWithObject:(PFObject *) object{
    
    if (self = [super init]) {
        _promoObject = object;
        _commentsArray = [NSMutableArray arrayWithArray:@[]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self requestComments];
}


-(void) setup{
    
    [self setTitle:@"Comentarios"];
   
    //Cell registration
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFCommentsCell class]) bundle:nil] forCellReuseIdentifier:kCommentCellIdentifier];
    
    [self.tableView setEstimatedRowHeight:95];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //Keyboard notification registration
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) requestComments{
    
    
    PFQuery *query = [PFQuery queryWithClassName:kCommentsClassName];
    [query whereKey:kCommentsAttributePromo equalTo:self.promoObject];
    [query orderByAscending:kAttributeCreatedAt];
    [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    @weakify(self);
    [query findObjectsInBackgroundWithBlock:^(NSArray *PF_NULLABLE_S objects, NSError *PF_NULLABLE_S error){
        
        @strongify(self);
        
        if (!error) {
            self.commentsArray = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
        }
        else{
            //TODO manejar el caso de error.
        }
    }];
    
}

#pragma mark UITableView Delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ARFCommentsCell *cell = (ARFCommentsCell *)[tableView dequeueReusableCellWithIdentifier:kCommentCellIdentifier];
    [cell configureCellWithObject:self.commentsArray[indexPath.row]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentsArray.count;
}

#pragma mark IBActions
- (IBAction)sendComment:(id)sender {
    
    [self.view endEditing:YES];
    
    PFObject *newComment = [PFObject objectWithClassName:kCommentsClassName];
    [newComment setObject:self.txtComment.text forKey:kCommentsAttributeText];
    [newComment setObject:self.promoObject forKey:kCommentsAttributePromo];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Enviando";
    
    [self.btnSend setEnabled:NO];
    
    @weakify(self, hud);
    [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *PF_NULLABLE_S error){
       
        @strongify(self, hud);
        [self.btnSend setEnabled:YES];
        [hud hide:YES];
        
        if (succeeded) {
            [self.txtComment setText:@""];
            [self requestComments];
        }
        else{
            //TODO manejar el error.
        }
    }];
}

@end
