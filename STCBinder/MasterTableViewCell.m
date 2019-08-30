//
//  MasterTableViewCell.m
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "MasterTableViewCell.h"

@interface MasterTableViewCell ()

@property (nonatomic, strong) UILabel *indexName;
@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UILabel *name;

@end

@implementation MasterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [self.contentView addSubview:self.imageIcon];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 80)];
        [self.contentView addSubview:self.name];
        
        self.indexName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 100, 80)];
        self.indexName.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.indexName];
        self.indexName.textAlignment = NSTextAlignmentRight;
        
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(180, 0, 80, 80)];
        [self.button setTitle:@"click" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.button.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (void)setModel:(CellModel *)model
{
    if (model.name && ![model.name isEqualToString:_model.name]) {
        self.name.text = model.name;
    }
    
    if (model.indexName && ![model.indexName isEqualToString:_model.indexName]) {
        self.indexName.text = model.indexName;
    }
    
    if (model.imageName && ![model.imageName isEqualToString:_model.imageName]) {
        self.imageIcon.image = [UIImage imageNamed:model.imageName];
    }
    
    if (!_model) {
        _model = [[CellModel alloc] init];
    }
    _model.name = model.name;
    _model.indexName = model.indexName;
    _model.imageName = model.imageName;
}

@end
