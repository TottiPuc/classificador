
% D.Mery, PUC-DCC, May 2010

function ds = clasificator_distancia_minima(varargin)

[train,test,X,d,Xt,options] = distributor(varargin{:});


options.string = 'distancia_minima    ';

if train

    m    = size(X,2);

    dmin = min(d);

    dmax = max(d);

    d    = d-dmin+1;

    n    = dmax-dmin+1;

    mc   = zeros(n,m);

    for i=1:n

        mc(i,:) = mean(X(d==i,:),1);

    end

    options.mc   = mc;

    options.dmin = dmin;

    ds = options;

end

if test

    mc = options.mc;

    n  = size(mc,1);

    Nt = size(Xt,1);

    ds = zeros(Nt,1);

    sc = zeros(Nt,1);

    for q=1:Nt

        D     = ones(n,1)*Xt(q,:)-mc;

        D2    = D.*D;

        e     = sum(D2,2);

        [i,j] = min(e);

        ds(q) = j;

        sc(q) = i;

    end

    ds = ds+options.dmin-1;

    ds = outscore(ds,sc,options);

end





