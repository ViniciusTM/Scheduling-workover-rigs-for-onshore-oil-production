###Parameters
#Extraction points
param N;

#Trucks
param T;

#Big M
param M;

#Number ositions in trucks route
param K;

#Production on extraction point i
param P{1..N};

#Repair duration on extraction point i
param S{1..N};

#Repair level on extraction point i
param L{1..N};

#Repair level of truck t
param Q{1..T};

#Time from extraction point i to j
param D{1..N, 1..N};

#Time from truck t starting point to the extraction point i
param E{1..T, 1..N};

###Variables
#Starting moment of the repair on extraction point i
var x{1..N};

#Binary varible
var y{1..T, 1..N, 1..K} binary;

###Objective Function
minimize cost: sum{i in 1..N}P[i]*x[i];

###Restrictions
#each extraction point must be in only one route
r1{i in 1..N}: sum{t in 1..T, k in 1..K}y[i,t,k] = 1;

#Position varible (y) restriction
r2{t in 1..T, k in 1..K}: sum{i in 1..N}y[t,i,k] <= 1;

#The extraction point most have a lower repair level than the truck
r3{i in 1..N, t in 1..T}: L[i]*sum{k in 1..K}y[t,i,k] <= Q[t];

#Restriction for solving the symmetry problem
r4{t in 1..T, k in 1..K-1}: sum{i in 1..N}(y[t,i,k+1] - y[t,i,k]);

#Temporal restriction
r5{}: x[j] >= x[i] + D[i] + S[i,j] - M*(2 - sum{r in 1..k}y[t,i,r] - sum{r in k+1..N}y[t,j,r]);

#First position temporal restriction
r6{i in 1..N}: x[i] >= sum{t in 1..T}y[t,i,1]*e[t,i];






