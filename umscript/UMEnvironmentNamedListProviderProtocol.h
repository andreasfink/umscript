//
//  UMEnvironmentNamedListProviderProtocol.h
//  umscript
//
//  Created by Andreas Fink on 04.05.20.
//

@protocol UMEnvironmentNamedListProviderProtocol<NSObject>

- (void)namedlistReplaceList:(NSString *)listName withContentsOfFile:(NSString *)filename;
- (void)namedlistsFlushAll;
- (void)namedlistsLoadFromDirectory:(NSString *)directory;
- (void)namedlistAdd:(NSString *)listName value:(NSString *)value;
- (void)namedlistRemove:(NSString *)listName value:(NSString *)value;
- (BOOL)namedlistContains:(NSString *)listName value:(NSString *)value;
- (NSArray *)namedlistGetAllEntriesOfList:(NSString *)listName; /* returns list of all entries in that list*/
- (NSArray<NSString *>*)namedlistsListNames;
- (UMNamedList *)getNamedList:(NSString *)name;
@end
