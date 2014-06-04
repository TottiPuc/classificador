 %#########  Christian Arcos  ########### 
%######  classificador mahalanobis  #########
 %#######   CETUC - PUC - RIO  ##########


%% training %%%

date = load('../Train.txt');
dateT = load('../Teste1.txt');

size (date)
d = date(:,end);  % valores da classe utima coluna
date(:,end) = []; % atributos

%plotfeatures(date,d)
disp ('gradico')
Xn = ['\beta_1';'\beta_2'];
%pause
k = 0;
k = k+1; b(k).name = 'distancia_minima'; b(k).options = [];   % minima distancia
k = k+1; b(k).name = 'distancia_mahalanobis'; b(k).options = [];   % distancia mahalanobis
opc = b;

opc = structure(date,d,opc)
disp('acabou de treinar')
pause

%%% Testing %%%%%

size(dateT)
dt = dateT(:,end);
dateT(:,end)=[];
disp('starting test')
ds = structure(dateT,opc);
disp('finish test')
p = performance(ds,dt)
pause











