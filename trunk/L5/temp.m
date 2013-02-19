cd D:\Projekty\ROB\L5

load rec.dat
load tstl.dat
lrec = tstl;

%stats
vbad = rec(:,1) == rec(:,2) & rec(:,1) == rec(:,3) & rec(:,1) == rec(:,4) & rec(:,1) == rec(:,5) & rec(:,1) != lrec; % 0.23%
bad = !vbad & rec(:,1) != lrec & rec(:,2) != lrec & rec(:,3) != lrec & rec(:,4) != lrec & rec(:,5) != lrec; % 0.13%
easy = rec(:,1) == rec(:,2) & rec(:,1) == rec(:,3) & rec(:,1) == rec(:,4) & rec(:,1) == rec(:,5) & rec(:,1) == lrec; % 95.55%
hard = !easy & (lrec == rec(:,1) | lrec == rec(:,2) | lrec == rec(:,3) | lrec == rec(:,4) | lrec == rec(:,5)); % 4.09%

sum(vbad)
sum(bad)
sum(easy)
sum(hard)
sum(vbad) + sum(bad) + sum(easy) + sum(hard)

randomSamples = randperm(size(rec, 1)) <= size(rec, 1) / 2;

tvec = rec(randomSamples, :);
tlab = lrec(randomSamples, :);
tstv = rec(!randomSamples, :);
tstl = lrec(!randomSamples, :);
