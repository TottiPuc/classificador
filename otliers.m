 %#########  Christian Arcos  ########### 
  %######  outlier detection  #########
%#######   CETUC - PUC - RIO  ##########

clc; clear; close all
X = load('../TesteTotal.txt');
NC = 5;  % number of class
col = (size(X,2)-1)
vector = [];
vectorout = [];
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
		%med = mean(Xiqr);
		med = mode(Xiqr);
		index_low = find(Xiqr<lowr );
		index_higr = find(Xiqr>highr );
		index_con = [index_low; index_higr];
		newXiqr(index_con) = med; % datos con outliers remplazados con la media
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		newYiqr = Y(Xiqr>lowr & Xiqr<highr);
		ini = l + 1;
		l +=inc;
		%size(Xiqr)
		%size(newXiqr)
		%size(index_low)
		%figure
		%hold on
		%plot(Xiqr,Y ,'bo', 'MarkerSize', 20) % datos originales
		%plot(newXiqr1,newYiqr, 'kx', 'MarkerSize', 20) % datos sin outliers
		%plot(newXiqr, Y, 'g+', 'MarkerSize', 20) % datos con outliers remplazados por la media
		%plot(newXiqr(index_con),index_con, 'r+', 'MarkerSize', 20) % medias remplazadas
		%hold off
		%pause
		%%%%%%%%%%%%%%% ouuput %%%%%%%%%%%%
		vector = [vector ; newXiqr];
		size(vector);
	end
	vectorout= [vectorout , vector];
	vector = [];
	
end	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% labels %%%%%%%%%%%%%%%%%%%%%%%%%%%%
pause
label = length (newXiqr)
labelX1E = ones(label,1);
labelX2E = 2*ones(label,1);
labelX3E = 3*ones(label,1);
labelX4E = 4*ones(label,1);
labelX5E = 5*ones(label,1);

labels = [labelX1E; labelX2E; labelX3E; labelX4E; labelX5E];

results = [vectorout,labels];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save ../Without_outliers.txt results -ascii

