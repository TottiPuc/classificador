%#########  Christian Arcos  ########### 
%######  Noise classification  #########
%#######   CETUC - PUC - RIO  ##########

%%%%%%  Reading audios  %%%%%%%% 

[x1,fs] = wavread('~/classificador/noiseComplete/babble.wav');
[y1,fs] = wavread('~/classificador/noiseComplete/white.wav');

x = x1./max(abs(x1));
y = y1./max(abs(y1));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%% Frame segmentation of 20 ms  %%%%%

N = 1600;
Nx =320; 
NFFT = 1024;
xs = enframe(x,N);
ys = enframe(y,N);
T = 1/fs;
outdivX = [];
outdivY = [];
outoriX = [];
outoriY = [];
cont = 0
for i = 1 : 5;
	Xframe = enframe (xs(i,:),Nx,160);
	Yframe = enframe (ys(i,:),Nx,160);
        dd = size (Xframe,1);
	for ii = 1: dd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%% fft %%%%%%%%%%%%

                X1 = abs(fft(Xframe(ii,:),NFFT));
		X = X1/(fs*NFFT);
        	Y1 = abs(fft(Yframe(ii,:),NFFT));
		Y = Y1/(fs*NFFT);
		magx = X(1:NFFT/2);
		magy = Y(1:NFFT/2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%%%%%%% lpc %%%%%%%%%%%%

		p = fs/1000 + 4;
		f = fs/2*linspace(0,1,NFFT/2);
                [a,g] = lpc (Xframe(ii,:),p);
                [b,h] = lpc (Yframe(ii,:),p);
		lspecX = abs(freqz(g,a,f,fs));
                lspecY = abs(freqz(h,b,f,fs));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%% segmentation in 5 bands %%%%%%%%
     %%%  entropy spectral calculation %%%%

		init = 1;
		incr = 32;
		
		for i = 1 : 5
			bandaX = lspecX(init:incr);
			bandaY = lspecY(init:incr);
			EntropyX = wentropy(bandaX, 'log energy');
                        EntropyY = wentropy(bandaY, 'log energy');
			attributeX(i)=EntropyX;
                        attributeY(i)=EntropyY;
			init = incr +1;
			incr *=2;
		end
		outdivX = [outdivX ; attributeX];
		outdivY = [outdivY ; attributeY];
		EntropyOriX = wentropy(lspecX, 'log energy');
		EntropyOriY = wentropy(lspecY, 'log energy');
		outoriX = [outoriX ; EntropyOriX];
		outoriY = [outoriY ; EntropyOriY];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%  plots  %%%%%%%%%%%%%%%%%

%        	l = length(Xframe(1,:));
%        	t = 0:T:(l-1)*T;
%		subplot(6,1,1), plot(t,Xframe(1,:))
%		subplot(6,1,2), plot(f,10*log10(magx))
%                subplot(6,1,3), plot(f,20*log10(lspecX),'k')
%                subplot(6,1,4), plot(t,Yframe(1,:))
%                subplot(6,1,5), plot(f,10*log10(magy))
%		subplot(6,1,6), plot(f,20*log10(lspecY),'k')

	end
cont +=1
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%  attribute labels %%%%%%%%%%%%%%%%%%%
labelX = ones(45,1);
labelY = 2*ones(45,1);
outBand = [outdivX; outdivY];
outOrig = [outoriX; outoriY];
labelOut = [labelX; labelY];
plotfeatures(outOrig,labelOut)
save ../bands.txt outBand -ascii
save ../full.txt outOrig -ascii
pause
