%#########  Christian Arcos  ########### 
%###### clasificador de ruidos #########
%#######   CETUC - PUC - RIO  ##########

%%%%%%  leitura de audios %%%%%%%% 

[e,fs] = wavread('~/classificador/noiseComplete/babble.wav');
[u,fs] = wavread('~/classificador/noiseComplete/white.wav');

x = e./max(abs(e));
y = u./max(abs(u));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   segmentação  %%%%%%%%%%%%
N = 1600;
Nx =320; 
NFFT = 1024;
xs = enframe(x,N);
ys = enframe(y,N);
fs
T = 1/fs
size(xs)
for i = 1 : 500;
%	disp('salio')
	Xframe = enframe (xs(i,:),Nx,160);
	Yframe = enframe (ys(i,:),Nx,160);
        dd = size (Xframe,1);
	for ii = 1: dd
%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%% fft %%%%%%%%%%%%
                X1 = abs(fft(Xframe(ii,:),NFFT));
		X = X1/(fs*NFFT);
        	Y1 = abs(fft(Yframe(ii,:),NFFT));
		Y = Y1/(fs*NFFT);
		magx = X(1:NFFT/2);
		magy = Y(1:NFFT/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%% lpc %%%%%%%%%%%%
		p = fs/1000 + 4
		f = fs/2*linspace(0,1,NFFT/2);
                [a,g] = lpc (Xframe(ii,:),p);
                [b,h] = lpc (Yframe(ii,:),p);
		lspecX = freqz(g,a,f,fs);
                lspecY = freqz(h,b,f,fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% segmentation in 5 bands %%%%%%%%
		init = 1;
		incr = 32;
		for i = 1 : 5
			bandaX = lspecX(init:incr);
			bandaY = lspecY(init:incr);
			freq = f(init:incr);
			init = incr +1
			incr *=2
		end
        	l = length(Xframe(1,:));
        	t = 0:T:(l-1)*T;
		subplot(6,1,1), plot(t,Xframe(1,:))
		subplot(6,1,2), plot(f,10*log10(magx))
                subplot(6,1,3), plot(f,20*log10(abs(lspecX)),'k')
                subplot(6,1,4), plot(t,Yframe(1,:))
                subplot(6,1,5), plot(f,10*log10(magy))
		subplot(6,1,6), plot(f,20*log10(abs(lspecY)),'k')
		pause
		
	end

end
size(Xframe)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plot (x)
%figure, plot(y)
pause



