%counterbalances the psycostim study
%heinously slow, and not at all optimised, this may take up to 1 hr to
%counterballence your study...
clear
n=24;
drug = fact({'PBO/ZOL;','DEX/ZOL;','DEX/PBO;','PBO/PBO;'},n);
taskSession1A = factNested({'WPA;','MOT;'},n);
taskSession1B = factNested({'WM;','EPT;','GNG;'},n);
taskSession2A = factNested({'WPA;','MOT;','EPT;','WM;'},n);
stark = fact({'StarkC;','StarkD;','StarkE;','StarkF;'},n);
WPA = fact({'Wordlist1;','Wordlist2;','Wordlist3;','Wordlist4;'},n);
taskSession1A.counterbalanceWith(drug);
disp('taskSession1A Balanced');
taskSession1B.counterbalanceWith(drug);
disp('taskSession1B Balanced');
taskSession2A.counterbalanceWith(drug);
disp('taskSession2A Balanced');
stark.counterbalanceWith(drug);
disp('stark Balanced');
WPA.counterbalanceWith(drug);
disp('WPA Balanced');

%create counterbalance file to save
counterBalance.drug=drug.balancedOutput();
counterBalance.taskSession1A=taskSession1A.balancedOutput();
counterBalance.taskSession1B=taskSession1B.balancedOutput();
counterBalance.taskSession2A=taskSession2A.balancedOutput();
counterBalance.stark=stark.balancedOutput();
counterBalance.WPA=WPA.balancedOutput();
%randomly shuffle subject order
randsort = randperm(n);
counterBalance.drug=counterBalance.drug(randsort,:);
counterBalance.taskSession1A=counterBalance.taskSession1A(randsort,:);
counterBalance.taskSession1B=counterBalance.taskSession1B(randsort,:);
counterBalance.taskSession2A=counterBalance.taskSession2A(randsort,:);
counterBalance.stark=counterBalance.stark(randsort,:);
counterBalance.WPA=counterBalance.WPA(randsort,:);
writetable(struct2table(counterBalance),'PSTIMCounterBalance.csv');