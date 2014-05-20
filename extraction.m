%#########  Christian Arcos  ########### 
%######    feature extraction  #########
%#######   CETUC - PUC - RIO  ##########

function [varargout] = extraction(varargin)
%%%%%%  Reading audios  %%%%%%%% 
if nargin == 3
	
	in = varargin{1};
	fs = varargin{2};
	x = in./max(abs(in));
	%x = in;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	   %%%%% Frame segmentation of 20 ms  %%%%%

	N = 1600;
	Nx =320; 
	NFFT = 1024;
	xs = enframe(x,N);
	T = 1/fs;
	outdivX = [];
	outoriX = [];
	outmeantimeX = [];
	outdevtimeX = [];
	outmeanspecX = [];
	outdevspecX = [];
	cruzezeroX =[];
	cruztotalX= [];
	%cont = 0
	for i = 1 : 500;
		Xframe = enframe (xs(i,:),Nx);
	        dd = size (Xframe,1);
		for ii = 1: dd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%%% frame to time %%%%%%
			Xt = Xframe(ii,:);
			
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	        %%%%%%%%%%% fft %%%%%%%%%%%%
                	X1 = abs(fft(Xframe(ii,:),NFFT));
			X = (X1/(fs*NFFT));
			magx = X(1:NFFT/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	          %%%%%%%%%% lpc %%%%%%%%%%%%

			p = fs/1000 + 4;
			f = fs/2*linspace(0,1,NFFT/2);
        	        [a,g] = lpc (Xframe(ii,:),p);
			lspecX = abs(freqz(g,a,f,fs));
			%plot (f, magx)
			%figure 
			%plot (f, lspecX)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%% segmentation in 5 bands %%%%%%%%
        %%%  entropy spectral and zerocross calculation %%%%

			initX = 1;
			incrX = 32;
			initY = 1;
                        incrY = 20;
		
			for i = 1 : 5
				bandaY = Xt(initY:incrY);
				bandaX = lspecX(initX:incrX);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%%%%%% spectral features band %%%%%%%%%%%

				%EntropyX = wentropy(bandaX, 'log energy')
				EntropyX = entropy(bandaX);
				attributeX(i)=EntropyX;
				cruzeX = zerocros(bandaY);
				long = length(cruzeX);
				cruzesX(i) = long;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	    %%%%%%%%%% time features band %%%%%%%%%%%%

				mediabandX = mean(bandaY);
				varbandX = std(bandaY);
				meantimeX(i) = mediabandX;
				stdtimeX(i) = varbandX;

                                initY = incrY +1;
                                incrY *=2;
					
				initX = incrX +1;
				incrX *=2;
			end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	   %%%%%%%  database spectral for band %%%%%%%%%

			outdivX = [outdivX ; attributeX];
			cruzezeroX = [cruzezeroX; cruzesX];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%%%  database time for band %%%%%%%%%%
	
			outmeantimeX = [outmeantimeX ; meantimeX];
			outdevtimeX = [outdevtimeX ; stdtimeX];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	   %%%%%%% database spectral for frame %%%%%%
			EntropyOriX = entropy(lspecX);
			%EntropyOriX = wentropy(lspecX, 'log energy');
			outoriX = [outoriX ; EntropyOriX];
			cruzToX = zerocros(Xt);
			long = length(cruzToX);
			cruztotalX = [cruztotalX; long];
			

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%%  database time for frame %%%%%%

			%meanframeX = (mean(lspecX));
			%varframeX = (std(lspecX));
                        meanframeX = (mean(Xt));
                        varframeX = (std(Xt));
			outmeanspecX = [outmeanspecX ; meanframeX];
        	        outdevspecX = [outdevspecX ; varframeX];
		end
	%cont +=1

	end
else 
	error('only audio, frequency and decision')
end
%%%%%%%%%%%%%%%% outputs according to decision %%%%%%%%%%%%%%%%%%%%%%%
if varargin{3} == 1
	varargout{1} = outdivX;
	varargout{2} = cruzezeroX;
	varargout{3} = outmeantimeX;
	varargout{4} = outdevtimeX;

elseif varargin{3} == 2
	varargout{1} = outoriX;
	varargout{2} = cruztotalX;
	varargout{3} = outmeanspecX;
	varargout{4} = outdevspecX;
else 
	error('invalid variable  decision "d" ')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
