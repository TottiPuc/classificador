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
%		disp('entro' )
		X = abs(fft(Xframe(ii,:),NFFT));
		magx =10*log(X(1:NFFT/2));
        	Y = abs(fft(Yframe(ii,:),NFFT));
        	magy = 10*log(Y(1:NFFT/2));
        	l = length(Xframe(1,:))
        	t = 0:T:(l-1)*T;
		f = fs/2*linspace(0,1,NFFT/2);
		subplot(4,1,1), plot(t,Xframe(1,:))
		subplot(4,1,2), plot(f,10*log(magx/NFFT)) 
                subplot(4,1,3), plot(t,Yframe(1,:))
                subplot(4,1,4), plot(f,10*log(magy/NFFT))
		pause
	end

end
size(Xframe)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plot (x)
%figure, plot(y)
pause



