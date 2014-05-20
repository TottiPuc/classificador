 %#########  Christian Arcos  ########### 
  %######  outlier detection  #########
%#######   CETUC - PUC - RIO  ##########

clc; clear; close all
X = load('../full.txt');
NC = 4;  % number of class
col = (size(X,2)-1)
for j = 1 : col
	l = length(X)/NC;
	inc = l;
	ini = 1;
	for i = 1 : NC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%% range interquartile %%%%%%%
		Xiqr = X((ini:l),j);
		Y = 1:length(Xiqr);
		IQR = iqr(Xiqr);
		lowr = prctile(Xiqr,25)-1.5*IQR;
	        highr = prctile(Xiqr,75)+1.5*IQR;
		newXiqr = Xiqr(Xiqr>lowr & Xiqr<highr)
		%index = find(newXiqr<lowr & newXiqr>highr)
		newYiqr = Y(Xiqr>lowr & Xiqr<highr);
		ini = l + 1
		l +=inc
		size(Xiqr)
		size(newXiqr)
		hold on
		plot(Xiqr,Y ,'bo', 'MarkerSize', 20)
		plot(newXiqr, newYiqr, 'kx', 'MarkerSize', 20)
	end
	
end	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
