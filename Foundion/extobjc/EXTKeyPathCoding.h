//
//  EXTKeyPathCoding.h
//  extobjc
//
//  Created by Justin Spahr-Summers on 19.06.12.
//  Copyright (C) 2012 Justin Spahr-Summers.
//  Released under the MIT license.
//

#import <Foundation/Foundation.h>
#import "metamacros.h"

/**
 * \@keypath allows compile-time verification of key paths. Given a real object
 * receiver and key path:
 *
 * @code

NSString *UTF8StringPath = @keypath(str.lowercaseString.UTF8String);
// => @"lowercaseString.UTF8String"

NSString *versionPath = @keypath(NSObject, version);
// => @"version"

NSString *lowercaseStringPath = @keypath(NSString.new, lowercaseString);
// => @"lowercaseString"

 * @endcode
 *
 * ... the macro returns an \c NSString containing all but the first path
 * component or argument (e.g., @"lowercaseString.UTF8String", @"version").
 *
 * In addition to simply creating a key path, this macro ensures that the key
 * path is valid at compile-time (causing a syntax error if not), and supports
 * refactoring, such that changing the name of the property will also update any
 * uses of \@keypath.
 */
#define keypath(...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))(keypath1(__VA_ARGS__))(keypath2(__VA_ARGS__))

#define keypath1(PATH) \
    (((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define keypath2(OBJ, PATH) \
    (((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

/**
 * \@collectionKeypath allows compile-time verification of key paths across collections NSArray/NSSet etc. Given a real object
 * receiver, collection object receiver and related keypaths:
 *
 * @code
 
 NSString *employessFirstNamePath = @collectionKeypath(department.employees, Employee.new, firstName)
 // => @"employees.firstName"
 
 NSString *employessFirstNamePath = @collectionKeypath(Department.new, employees, Employee.new, firstName)
 // => @"employees.firstName"

 * @endcode
 *
 */
#define collectionKeypath(...) \
    metamacro_if_eq(3, metamacro_argcount(__VA_ARGS__))(collectionKeypath3(__VA_ARGS__))(collectionKeypath4(__VA_ARGS__))

#define collectionKeypath3(PATH, COLLECTION_OBJECT, COLLECTION_PATH) ([[NSString stringWithFormat:@"%s.%s",keypath(PATH), keypath(COLLECTION_OBJECT, COLLECTION_PATH)] UTF8String])

#define collectionKeypath4(OBJ, PATH, COLLECTION_OBJECT, COLLECTION_PATH) ([[NSString stringWithFormat:@"%s.%s",keypath(OBJ, PATH), keypath(COLLECTION_OBJECT, COLLECTION_PATH)] UTF8String])

/**
 \@keypathClassInstance allows compile-time verification of key paths. Similar to
 \@keypath, but accept a class as parameter instead of a instance variable.
 @code
 
 NSString *objectIDPath = @keypathClassInstance(NSManagedObject, objectID);
 // => @"objectID"
 
 NSString *footerViewFramePath = @keypathClassInstance(UITableView, tableFooterView, frame);
 // => @"frame"
 
 @endcode
 
 @bug In a class method, cannot use `self` as CLASS.
 */

#define keypathClassInstance(...)\
metamacro_if_eq(2, metamacro_argcount(__VA_ARGS__))(keypathClassInstance1(__VA_ARGS__))(keypathClassInstance2(__VA_ARGS__))

#define keypathClassInstance1(CLASS, PATH)\
(({CLASS *_proxy_; ((void)(NO && ((void)_proxy_.PATH, NO)), # PATH);}))

#define keypathClassInstance2(CLASS, PROPERTY, PATH)\
(({CLASS *_proxy_; ((void)(NO && ((void)_proxy_.PROPERTY.PATH, NO)), # PATH);}))

#pragma mark - Language Addition

/** Define a const NSString
 
 @code
 
 RFDefineConstString(aaa);
 RFDefineConstString(bbb, "something");
 
 // Will be
 NSString *const aaa = @"aaa";
 NSString *const bbb = @"something";
 
 @endcode
 */
#define RFDefineConstString(...) metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))(_RFDefineConstString1(metamacro_at0(__VA_ARGS__)))(_RFDefineConstString2(metamacro_at0(__VA_ARGS__), metamacro_at1(__VA_ARGS__)))

#define _RFDefineConstString1(name) NSString *const name = @metamacro_stringify_(name)
#define _RFDefineConstString2(name, value) NSString *const name = @value