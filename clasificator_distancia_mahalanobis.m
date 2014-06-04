% D.Mery, PUC-DCC, May 2010

% http://dmery.ing.puc.cl



function [ds,options] = clasificator_distancia_mahalanobis(varargin)

[train,test,X,d,Xt,options] = distributor(varargin{:});



options.string = 'distancia_mahalanobis    ';

if train

    m    = size(X,2);

    dmin = min(d);

    dmax = max(d);

    n    = dmax-dmin+1;

    d    = d-dmin+1;

    mc   = zeros(n,m);

    M    = size(X,2);

    Ck   = zeros(M,M,n);

    for i=1:n

        ii = find(d==i);

        mc(i,:) = mean(X(ii,:),1);

        CCk = cov(X(ii,:));      % covariance of class i

        Ck(:,:,i) = CCk;

    end

    options.mc   = mc;

    options.dmin = dmin;

    options.Ck    = Ck;

    ds = options;

end

if test

    mc    = options.mc;

    n     = size(mc,1);

    Nt    = size(Xt,1);

    ds    = zeros(Nt,1);

    sc    = ds;

    for k=1:n

        Ck(:,:,k) = inv(options.Ck(:,:,k));

    end

    for q=1:Nt

        dk = zeros(n,1);

        for k=1:n

            dx = Xt(q,:)-options.mc(k,:);

            dk(k) = dx*Ck(:,:,k)*dx';

        end

        [i,j] = min(dk);

        ds(q) = j;

        sc(q) = i;

    end

    ds = ds+options.dmin-1;

    ds = outscore(ds,sc,options);

end


