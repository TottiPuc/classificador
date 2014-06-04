%#########  Christian Arcos  ########### 
%######  Noise classification  #########
%#######   CETUC - PUC - RIO  ##########


[x1,fs] = wavread('~/classificador/noiseComplete/babble.wav');
[x2,fs] = wavread('~/classificador/noiseComplete/white.wav');
[x3,fs] = wavread('~/classificador/noiseComplete/pink.wav');
[x4,fs] = wavread('~/classificador/noiseComplete/volvo.wav');
[x5,fs] = wavread('~/classificador/noiseComplete/factory1.wav');


fprintf('type: \n 1- if you want to split band data   \n 2- if you full frame data\n')
disp('')
d = input('type: ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% features with division band %%%%%%%%%%%%%%%%%%%%
if d == 1

	[X1E, X1Z, X1M, X1D, X1En] = extraction(x1,fs,d);
	[X2E, X2Z, X2M, X2D, X2En] = extraction(x2,fs,d);	
	[X3E, X3Z, X3M, X3D, X3En] = extraction(x3,fs,d);
	[X4E, X4Z, X4M, X4D, X4En] = extraction(x4,fs,d);
        [X5E, X5Z, X5M, X5D, X5En] = extraction(x5,fs,d);

	l = length(X1E);
	labelX1E = ones(l,1);
	labelX2E = 2*ones(l,1);
	labelX3E = 3*ones(l,1);
	labelX4E = 4*ones(l,1);
	labelX5E = 5*ones(l,1);

	Y = [[X1E,X1Z,X1M,X1D,X1En,labelX1E]; [X2E,X2Z,X2M,X2D,X2En,labelX2E]; [X3E,X3Z,X3M,X3D,X3En,labelX3E]; [X4E,X4Z,X4M,X4D,X4En,labelX4E]; [X5E,X5Z,X5M,X5D,X5En,labelX5E]];
	%Y = [[X1E,X1Z,X1M,X1D]; [X2E,X2Z,X2M,X2D]; [X3E,X3Z,X3M,X3D]; [X4E,X4Z,X4M,X4D]];
	%X1 = [[X1M,X1D]; [X2M,X2D]; [X3M,X3D]; [X4M,X4D]];
	labels = [labelX1E; labelX2E; labelX3E; labelX4E; labelX5E];
size(Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% features full frame %%%%%%%%%%%%%%%%%%%%%%%%

elseif d == 2

	[X1E, X1Z, X1M, X1D, X1En] = extraction(x1,fs,d);
	[X2E, X2Z, X2M, X2D, X2En] = extraction(x2,fs,d);
	[X3E, X3Z, X3M, X3D, X3En] = extraction(x3,fs,d);
	[X4E, X4Z, X4M, X4D, X4En] = extraction(x4,fs,d);
        [X5E, X5Z, X5M, X5D, X5En] = extraction(x5,fs,d);

	l = length(X1E)
        labelX1E = ones(l,1);
        labelX2E = 2*ones(l,1);
        labelX3E = 3*ones(l,1);
        labelX4E = 4*ones(l,1);
        labelX5E = 5*ones(l,1);

size(X1E)
        X = [[X1E,X1Z,X1M,X1D,X1En,labelX1E]; [X2E,X2Z,X2M,X2D,X2En,labelX2E]; [X3E,X3Z,X3M,X3D,X3En,labelX3E]; [X4E,X4Z,X4M,X4D,X4En,labelX4E]; [X5E,X5Z,X5M,X5D,X5En,labelX5E]];
       % X = [[X1E,X1Z,X1M,X1D]; [X2E,X2Z,X2M,X2D]; [X3E,X3Z,X3M,X3D]; [X4E,X4Z,X4M,X4D]];
size(X)
	%X1 = [[X1M,X1D]; [X2M,X2D]; [X3M,X3D]; [X4M,X4D]];
        %X2 = [[X1E,X1D]; [X2E,X2D]; [X3E,X3D]; [X4E,X4D]];
        %X3 = [[X1M,X1E]; [X2M,X2E]; [X3M,X3E]; [X4M,X4E]];
        labels = [labelX1E; labelX2E; labelX3E; labelX4E; labelX5E];
%%%%%%%	
elseif d == 3

        [X1E, X1Z, X1M, X1D, X1En] = extraction(x1,fs,d);
        [X2E, X2Z, X2M, X2D, X2En] = extraction(x2,fs,d);
        [X3E, X3Z, X3M, X3D, X3En] = extraction(x3,fs,d);
        [X4E, X4Z, X4M, X4D, X4En] = extraction(x4,fs,d);
        [X5E, X5Z, X5M, X5D, X5En] = extraction(x5,fs,d);

        l = length(X1E)
        labelX1E = ones(l,1);
        labelX2E = 2*ones(l,1);
        labelX3E = 3*ones(l,1);
        labelX4E = 4*ones(l,1);
        labelX5E = 5*ones(l,1);

size(X1E)
        Z = [[X1E,X1Z,X1M,X1D,X1En,labelX1E]; [X2E,X2Z,X2M,X2D,X2En,labelX2E]; [X3E,X3Z,X3M,X3D,X3En,labelX3E]; [X4E,X4Z,X4M,X4D,X4En,labelX4E]; [X5E,X5Z,X5M,X5D,X5En,labelX5E]];
       % X = [[X1E,X1Z,X1M,X1D]; [X2E,X2Z,X2M,X2D]; [X3E,X3Z,X3M,X3D]; [X4E,X4Z,X4M,X4D]];
size(Z)
        %X1 = [[X1M,X1D]; [X2M,X2D]; [X3M,X3D]; [X4M,X4D]];
        %X2 = [[X1E,X1D]; [X2E,X2D]; [X3E,X3D]; [X4E,X4D]];
        %X3 = [[X1M,X1E]; [X2M,X2E]; [X3M,X3E]; [X4M,X4E]];
        labels = [labelX1E; labelX2E; labelX3E; labelX4E; labelX5E];



%%%%%%%%%%

else

	error ('type in  between 1 and 2')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%      plot features     %%%%%%%%%%%%%%%%%%%%%%%%%%

%plotfeatures(X,labels)
%figure
%plotfeatures(X2,labels)
%figure
%plotfeatures(X3,labels)
%pause
save ../bands.txt Y -ascii
%save ../full.txt  X -ascii
%save ../Total.txt Z -ascii



