# AutoCounterBalence
Automatically perform counterbalancing of conditions for experiments.

This code will counterbalence conditions with respect to each other. If you dont know what this means, then dont use this code...
Use this code at your own risk, its has not be thoroughly tested and is in no way optimized. 

This code is best explained with examples:
### Example 1:
3 between subjects factor (Time: 3hrs or 7 Days, Catergory: A or B, Room: 1 or 2)
1 factor all subjects get (Final Room Order: A,B,C,D)

We would like to: 
- a) Balence the Catergory and Room, such that no timing condition (3hr/7day) gets more or less of them
- b) Balence the order of Final Room Order, such that each ordering apears the same amount in each timing condition

The code for this is as follows:
```
clear
n=64;
cond = fact({'3Hr;','7Day;'},n);
category = fact({'1;','2;'},n);
category.counterbalenceWith(cond);
initalRoom = fact({'C;','D;'},n);
initalRoom.counterbalenceWith(cond);
initalRoom.counterbalenceWith(cat);
finalRoom = factNested({'A;','B;','C;','D;'},n);
finalRoom.counterbalenceWith(cond);


%create counterbalence file to save
counterBalence.cond=cond.balencedOutput();
counterBalence.category=category.balencedOutput();
counterBalence.initalRoom=initalRoom.balencedOutput();
counterBalence.finalRoom=finalRoom.balencedOutput();
%randomly shuffle subject order
randsort = randperm(n);
counterBalence.cond=counterBalence.cond(randsort,:);
counterBalence.cat=counterBalence.cat(randsort,:);
counterBalence.room1=counterBalence.room1(randsort,:);
counterBalence.session4=counterBalence.session4(randsort,:);
writetable(struct2table(counterBalence),'CounterBalenceGen.csv');

```
