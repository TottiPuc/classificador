 %#########  Christian Arcos  ########### 
%######  clasification structure  #########
 %#######   CETUC - PUC - RIO  ##########

function  [out , options] = structure(varargin)
[train,test,X,d,Xt,options] = distributor(varargin{:});
b = options;
n = length(b);

if train 
	for i = 1:n
	  	class = b(i).name;
		class = ['clasificator_' class]
		b(i).options = feval(class,X,d,b(i).options);
    	end
    	options = b;
    	out  = options;
end
if test
    nt = size(Xt,1);
    ds3 = zeros(nt,n,2);
    d3 = 0;
    for i=1:n
        class = b(i).name;
        class = ['clasificator_' class];
        dsi = feval(class,Xt,b(i).options);
        ds3(:,i,1) = dsi(:,1);
        if size(dsi,2)==2
            ds3(:,i,2) = dsi(:,2);
            d3 = 1;
        end
    end
    if d3
        out = ds3;
    else
        out = ds3(:,:,1);
    end
end
