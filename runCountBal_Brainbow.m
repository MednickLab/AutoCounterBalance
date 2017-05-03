%heinously slow, and not at all optimised, this may take up to 20mins to
%counterballence your study...
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