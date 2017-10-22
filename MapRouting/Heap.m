//
//  Heap.m
//  MapRouting
//
//  Created by xmeng17 on 2/5/17.
//  Copyright © 2017 xmeng17. All rights reserved.
//

#import "Heap.h"

@implementation Heap


-(instancetype)init{
    self=[super init];
    self.list=[[NSMutableArray alloc]init];
    return self;
}

-(void)insert:(Vertex*)vert{
    [self.list addObject:vert];
    [self shiftup:(int)[self.list count]-1];
}

-(Vertex*)extractMin{
    //return the minimum item, which is the first one, in the list
    if([self.list count]==0){
        return nil;
    }else if([self.list count]==1){
        Vertex* min=[self.list objectAtIndex:0];
        [self.list removeObjectAtIndex:0];
        return min;
    }else{
        Vertex* min=[self.list objectAtIndex:0];
        //delete the first one, and replace it with the last one, which is one of the greatest in the list
        [self.list replaceObjectAtIndex:0 withObject:[self.list objectAtIndex:[self.list count]-1]];
        [self.list removeObjectAtIndex:[self.list count]-1];
        //repair the list
        [self shiftdown:0];
        return min;
    }
}

-(void)updateVertex:(Vertex*)vertex{
    int ind=(int)[self.list indexOfObject:vertex];
    NSLog(@"%d",ind);
    [self shiftup:ind];
}



-(void)shiftup:(int)index{
    //shifts a given vertex up to its right position by swaping it continuously with its ancestor
    if(index==0)return;
    Vertex* original=[self.list objectAtIndex:index];
    int current=index;
    int parent=[self parent:current];
    Vertex* parentvert=[self.list objectAtIndex:parent];
    //if currently child is smaller than parent
    while (original.distance<parentvert.distance) {
        [self.list replaceObjectAtIndex:current withObject:parentvert];
        current = parent;
        if(current==0){
            break;
        }
        parent=[self parent:current];
        parentvert=[self.list objectAtIndex:parent];
    }
    [self.list replaceObjectAtIndex:current withObject:original];
}

-(void)shiftdown:(int)index{
    //shifts a given vertex down to its right position by swaping it continuously with its descendent
    int current=index;
    
    ///for each loop, set min to current, if leftchild of current is smaller, set min to leftchild, if rightchild of current exist and is smaller, set min to rightchild
    while(true){
        int min=current;
        Vertex* minvert=[self.list objectAtIndex:min];

        int leftchild=[self leftchild:current];
        if(leftchild>=[self.list count])return;
        Vertex* leftchildvert=[self.list objectAtIndex:leftchild];
        if(leftchildvert.distance<minvert.distance){
            min=leftchild;
            minvert=leftchildvert;
        }
        
        int rightchild=[self rightchild:current];
        if(rightchild<[self.list count]){
            Vertex* rightchildvert=[self.list objectAtIndex:rightchild];
            if(rightchildvert.distance<minvert.distance){
                min=rightchild;
                minvert=rightchildvert;
            }
        }
        if(min==current)break;
        [self.list exchangeObjectAtIndex:current withObjectAtIndex:min];
        current=min;
    }
}

-(int)parent:(int)i{
    return (i-1)/2;
}

-(int)leftchild:(int)i{
    return 2*i+1;
}

-(int)rightchild:(int)i{
    return 2*i+2;
}


@end
