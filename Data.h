//
//  Data.h
//  Why Go Solo
//
//  Created by Andy Chamberlain on 18/09/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class University;
@class Residence;
@protocol DataDelegate <NSObject>

-(void)authenticationSuccessful;

-(void)universitiesDownloadedSuccessfully;
-(void)residencesDownloadedSuccessfully;

@end

@interface Data : NSObject

@property (nonatomic, weak) id <DataDelegate> delegate;

+ (Data*)sharedInstance;



@property NSMutableArray* universitesArray;
@property NSMutableArray* residencesArray;


@property University *selectedUniversity;
@property Residence *selectedResidence;

//-(void)createUserFromDict:(NSDictionary *)dict;
-(void)createUniversitesArrayFromDict:(NSDictionary *)dict;

-(void)createResidencesArrayFromDict:(NSDictionary *)dict;

-(void)authenticationSuccessful;
@end
