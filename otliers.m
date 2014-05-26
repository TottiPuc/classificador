 %#########  Christian Arcos  ########### 
  %######  outlier detection  #########
%#######   CETUC - PUC - RIO  ##########

clc; clear; close all
X = load('../Total.txt');
NC = 4;  % number of class
col = (size(X,2)-1)
for j = 1 : col
	disp ('columna :'); j
	l = length(X)/NC
	inc = l;
	ini = 1;
	for i = 1 : NC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%% range interquartile %%%%%%%
		Xiqr = X((ini:l),j); % datos con outliers
		newXiqr = Xiqr;
		Y = 1:length(Xiqr);
		IQR = iqr(Xiqr);
		lowr = prctile(Xiqr,25)-1.5*IQR;
	        highr = prctile(Xiqr,75)+1.5*IQR;
		newXiqr1 = Xiqr(Xiqr>lowr & Xiqr<highr); % datos sin outliers
		%%%%%%%%%% replace %%%%%%%%%%%
		med = mean(Xiqr);
		index_low = find(Xiqr<lowr );
		index_higr = find(Xiqr>highr );
		index_con = [index_low; index_higr];
		newXiqr(index_con) = med; % datos con outliers remplazados con la media
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		newYiqr = Y(Xiqr>lowr & Xiqr<highr);
		ini = l + 1
		l +=inc
		%size(Xiqr)
		%size(newXiqr)
		%size(index_low)
		figure
		hold on
		plot(Xiqr,Y ,'bo', 'MarkerSize', 20) % datos originales
		plot(newXiqr1,newYiqr, 'kx', 'MarkerSize', 20) % datos sin outliers
		plot(newXiqr, Y, 'g+', 'MarkerSize', 20) % datos con outliers remplazados por la media
		plot(newXiqr(index_con),index_con, 'r+', 'MarkerSize', 20) % medias remplazadas
		hold off
		pause
	end
	
end	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
