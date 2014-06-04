% D.Mery, PUC-DCC, 2010

% http://dmery.ing.puc.cl



function p = performance(d1,d2,nn)



d1 = single(d1);

d2 = single(d2);



n1 = size(d1,2);

n2 = size(d2,2);



if (n1==1) || (n2==1)



    if n2>n1

        ds = d2;

        d  = d1;

    else

        d  = d2;

        ds = d1;

    end



    n = size(ds,2);

    p = zeros(n,1);

    for i=1:n

        if exist('nn','var');

            [T,pp] = confusion(d,ds(:,i),nn)  %  resultados matriz de confusion

        else

            [T,pp] = confusion(d,ds(:,i))  %  resultados matriz de confunsion

        end

        p(i) = mean(pp);

    end



else

    error('performance: at least d1 or d2 must have only one column.');

end
