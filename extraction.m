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
	%cont = 0
	for i = 1 : 500;
		Xframe = enframe (xs(i,:),Nx,160);
	        dd = size (Xframe,1);
		for ii = 1: dd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	        %%%%%%%%%%% fft %%%%%%%%%%%%

                	X1 = abs(fft(Xframe(ii,:),NFFT));
			X = X1/(fs*NFFT);
			magx = X(1:NFFT/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	          %%%%%%%%%% lpc %%%%%%%%%%%%

			p = fs/1000 + 4;
			f = fs/2*linspace(0,1,NFFT/2);
        	        [a,g] = lpc (Xframe(ii,:),p);
			lspecX = abs(freqz(g,a,f,fs));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%% segmentation in 5 bands %%%%%%%%
	     %%%  entropy spectral calculation %%%%

			init = 1;
			incr = 32;
		
			for i = 1 : 5
				bandaX = lspecX(init:incr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%%%%%% spectral features band %%%%%%%%%%%

				EntropyX = wentropy(bandaX, 'log energy');
				attributeX(i)=EntropyX;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	    %%%%%%%%%% time features band %%%%%%%%%%%%

				mediabandX = mean(bandaX);
				varbandX = std(bandaX);
				meantimeX(i) = mediabandX;
				stdtimeX(i) = varbandX;
				init = incr +1;
				incr *=2;
			end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	   %%%%%%%  database spectral for band %%%%%%%%%

			outdivX = [outdivX ; attributeX];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%%%  database time for band %%%%%%%%%%
	
			outmeantimeX = [outmeantimeX ; meantimeX];
			outdevtimeX = [outdevtimeX ; stdtimeX];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	   %%%%%%% database spectral for frame %%%%%%

			EntropyOriX = wentropy(lspecX, 'log energy');
			outoriX = [outoriX ; EntropyOriX];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%%  database time for frame %%%%%%

			meanframeX = 10*log10(mean(lspecX));
			varframeX = 10*log10(std(lspecX));
			outmeanspecX = [outmeanspecX ; meanframeX];
        	        outdevspecX = [outdevspecX ; varframeX];

		end
	%cont +=1

	end
else 
	error('only audio, frequency and decision')
end
%%%%%%%%%%%%%%%% outputs according to decision %%%%%%%%%%%%%%%%%%%%%%%
cont = 0;
if varargin{3} == 1
cont += 1
	varargout{1} = outdivX;
	varargout{2} = outmeantimeX;
	varargout{3} = outdevtimeX;

elseif varargin{3} == 2
cont += 1
	varargout{1} = outoriX;
	varargout{2} = outmeanspecX;
	varargout{3} = outdevspecX;
else 
	error('invalid variable  decision "d" ')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
