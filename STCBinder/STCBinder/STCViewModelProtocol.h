//
//  STCViewModelProtocol.h
//  STCBinder
//
//  Created by chenxiancai on 24/09/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#ifndef STCViewModelProtocol_h
#define STCViewModelProtocol_h

@protocol STCViewModelProtocol <NSObject>

@optional
/**
 update value
 
 @param value value
 @param viewModel viewModel
 @param target target
 */
- (void)updateValue:(id)value withViewModel:(id)viewModel target:(id)target;

@end

#endif /* STCViewModelProtocol_h */
