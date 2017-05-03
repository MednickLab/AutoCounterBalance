# AutoCounterBalance
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
cat = fact({'1;','2;'},n);
cat.counterbalanceWith(cond);
room1 = fact({'C;','D;'},n);
room1.counterbalanceWith(cond);
room1.counterbalanceWith(cat);
session4 = factNested({'C;','D;','B;','B(MemA);'},n);
session4.counterbalanceWith(cond);

%create counterbalance file to save
counterBalance.cond=cond.balancedOutput();
counterBalance.cat=cat.balancedOutput();
counterBalance.room1=room1.balancedOutput();
counterBalance.session4=session4.balancedOutput();
%randomly shuffle subject order
randsort = randperm(n);
counterBalance.cond=counterBalance.cond(randsort,:);
counterBalance.cat=counterBalance.cat(randsort,:);
counterBalance.room1=counterBalance.room1(randsort,:);
counterBalance.session4=counterBalance.session4(randsort,:);
writetable(struct2table(counterBalance),'CounterBalanceGen.csv');
```
