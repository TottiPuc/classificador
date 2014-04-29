%#########  Christian Arcos  ########### 
%###### clasificador de sinais #########
%#######   CETUC - PUC - RIO  ##########

%%%%%%  leitura de audios %%%%%%%% 

[x,fs] = wavread('~/classificador/noiseComplete/babble.wav');
[y,fs] = wavread('~/classificador/noiseComplete/white.wav');

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
        dd = size (Xframe,1)
	for ii = 1: dd
%%%%%%%%%%% fft %%%%%%%%%%%%%%%%%%%%%%%%%%%
		X = abs(fft(Xframe(ii,:),NFFT));
                Y = abs(fft(Yframe(ii,:),NFFT));
		magx1 = X(1:NFFT/2);
                magy1 = Y(1:NFFT/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%% PDS %%%%%%%%%%%%
                X1 = fft(Xframe(ii,:),NFFT);
		PDSx = X1.*conj(X1);
                magx = PDSx(1:NFFT/2);
        	Y1 = fft(Yframe(ii,:),NFFT);
		PDSy = Y1.*conj(Y1);
        	magy = PDSy(1:NFFT/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%% lpc %%%%%%%%%%%%

		p = fs/1000 + 4;
		f = fs/2*linspace(0,1,NFFT/2);
		[a,g] = ilpc (magx,p);
		[b,h] = ilpc (magy,p);
                [a1,g1] = ilpc (magx1,p);
                [b1,h1] = ilpc (magy1,p);
		lspecX = freqz(g,a,f,fs);
                lspecY = freqz(h,b,f,fs);
                lspecX1 = freqz(g1,a1,f,fs);
                lspecY1 = freqz(h1,b1,f,fs);
        	l = length(Xframe(1,:));
        	t = 0:T:(l-1)*T;
		subplot(4,1,1), plot(t,Xframe(1,:))
		subplot(4,1,2), plot(f,10*log(magx/NFFT)) 
                subplot(4,1,3), plot(t,Yframe(1,:))
                subplot(4,1,4), plot(f,10*log(magy/NFFT))
		figure
                subplot(4,1,1), plot(f,20*log10(abs(lspecX1)),'k')
		subplot(4,1,2), plot(f,20*log10(abs(lspecX)),'k')
                subplot(4,1,3), plot(f,20*log10(abs(lspecY1)),'k')
		subplot(4,1,4), plot(f,20*log10(abs(lspecY)),'k')
		pause
	end

end
size(Xframe)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plot (x)
%figure, plot(y)
pause



