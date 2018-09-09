//
//  WeakTableTest.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/9/9.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "WeakTableTest.h"

@implementation WeakTableTest

void *objc_destructInstance(id obj)
{
    object_cxxDestruct(obj);
    _object_remove_assocations(obj);
    clearDeallocating();
}

void clearDeallocating()
{
    if (!isa.nonpointer)
    {
        sidetable_clearDeallocating();
    }
    else
    {
        clearDeallocating_slow();
    }
}

void sidetable_clearDeallocating()
{
    SideTable.lock();
    
    weak_clear_no_lock(&SideTable.weak_table, (id)this);
    SideTable.refcnts.erase(it);
    
    SideTable.unlock();
}

void clearDeallocating_slow()
{
    SideTable.lock();

    weak_clear_no_lock(&SideTable.weak_table, (id)this);
    SideTable.refcnts.erase(this);
    
    SideTable.unlock();
}

void weak_clear_no_lock(weak_table_t *weak_table, id referent_id)
{
    weak_entry_t *entry = weak_entry_for_referent(weak_table, referent_id);
    weak_referrer_t *referrers = entry->referrers;
    size_t count = TABLE_SIZE(entry);

    for (size_t i = 0; i < count; ++i)
    {
        objc_object **referrer = referrers[i];
        *referrer = nil;

    }
    
    weak_entry_remove(weak_table, entry);
}
/**
 runtime底层使用objc_destructInstance方法销毁一个实例对象;
 在此方法中系统首先调用此对象的析构函数，然后去除关联对象，最后调用clearDeallocating函数进行后续清理;
 在此方法中系统会判断对象是否使用了isa优化技术，如果isa进行了优化会调用clearDeallocating_slow函数，否则会调用sidetable_clearDeallocating函数；
 在clearDeallocating_slow或clearDeallocating_slow方法中，
 系统会调用weak_clear_no_lock函数清理sideTable的weak_table_t,
 并且会调用erase方法清理sideTable的RefcountMap引用计数表；
 在weak_clear_no_lock函数中，根据对象的地址查找到对应的weak_entry_t，并遍历weak_entry_t中weak_referrer_t中存储的所有weak指针，并全部设为nil；
 
 当一个实例对象被销毁时，底层会调用objc_destructInstance
 对象会调用sidetable_clearDeallocating方法;
 在sidetable_clearDeallocating方法中会调用weak_clear_no_lock方法，
 此方法会传入两个参数，一个sideTable的weak_table_t，一个是实例对象的地址；
 */
@end
