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
	outenerX=[];
	outenertimeY=[];
	outmeanspecXT=[];
	outoriXT =[];
	cruztotalXT =[];
	outdevspecXT=[];
	outenerXT =[];
	%cont = 0
	for i = 1 : 500;
		XTot = xs(i,:);
		Xframe = enframe (XTot,Nx);
	        dd = size (Xframe,1);

%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%%% Big frame %%%%%
		XTot = xs(i,:);
                pT = fs/1000 + 4;
                f = fs/2*linspace(0,1,NFFT/2);
                [aT,gT] = lpc (XTot,pT);
                lspecXT = abs(freqz(gT,aT,f,fs));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           %%%%%%% database spectral for frame %%%%%%
                EntropyOriXT = entropy(lspecXT);
               %EntropyOriX = wentropy(lspecX, 'log energy');
                outoriXT = [outoriXT ; EntropyOriXT];
                cruzToXT = zerocros(XTot);
                longT = length(cruzToXT);
                cruztotalXT = [cruztotalXT; longT];

               %%%%%%%% energy to frame %%%%%%%%%
               framelenT = length(XTot);
               valuemeanT = sum(abs(XTot))/(framelenT +1);
               enerXT = sum(((abs(XTot))-valuemeanT).^2)/framelenT;
               enerT = 10*log10(enerXT);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             %%%%%%  database time for frame %%%%%%

                 meanframeXT = (mean(XTot));
                 varframeXT = (std(XTot));
                 outmeanspecXT = [outmeanspecXT ; meanframeXT];
                 outdevspecXT = [outdevspecXT ; varframeXT];
                 outenerXT = [outenerXT ; enerT];

%%%%%%%%




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
				lenY = length(bandaY);
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

				framelenY = length(bandaY);
                        	valuemeanY = sum(abs(bandaY))/(lenY +1);
	                        enerY(i) = 10*log10(sum(((abs(bandaY))-valuemeanY).^2)/lenY);

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
			outenertimeY = [outenertimeY ; enerY];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	   %%%%%%% database spectral for frame %%%%%%
			EntropyOriX = entropy(lspecX);
			%EntropyOriX = wentropy(lspecX, 'log energy');
			outoriX = [outoriX ; EntropyOriX];
			cruzToX = zerocros(Xt);
			long = length(cruzToX);
			cruztotalX = [cruztotalX; long];
			
	       %%%%%%%% energy to frame %%%%%%%%%
			framelen = length(Xt);
			valuemean = sum(abs(Xt))/(framelen +1);
			enerX = sum(((abs(Xt))-valuemean).^2)/framelen; 
			ener = 10*log10(enerX);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	     %%%%%%  database time for frame %%%%%%

			%meanframeX = (mean(lspecX));
			%varframeX = (std(lspecX));
                        meanframeX = (mean(Xt));
                        varframeX = (std(Xt));
			outmeanspecX = [outmeanspecX ; meanframeX];
        	        outdevspecX = [outdevspecX ; varframeX];
			outenerX = [outenerX ; ener];
%		l = length(Xt);
%		t = 0:T:(l-1)*T;
%		subplot(3,1,1), plot(t,Xt)
%		subplot(3,1,2), plot(f,10*log10(magx))
 %               subplot(3,1,3), plot(f,10*log10(lspecX),'k')
%pause
		end
%plot(outdevtimeX)
%figure	%cont +=1
%plot(outenerX)
%pause
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
	varargout{5} = outenertimeY;

elseif varargin{3} == 2
	varargout{1} = outoriX;
	varargout{2} = cruztotalX;
	varargout{3} = outmeanspecX;
	varargout{4} = outdevspecX;
        varargout{5} = outenerX;

elseif varargin{3} == 3
        varargout{1} = outoriXT;
        varargout{2} = cruztotalXT;
        varargout{3} = outmeanspecXT;
        varargout{4} = outdevspecXT;
        varargout{5} = outenerXT;
else 
	error('invalid variable  decision "d" ')

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
