% D.Mery, PUC-DCC, 2010

% http://dmery.ing.puc.cl


function [T,p] = confusion(d,ds,nn)

if exist('nn','var');

    n1 = max(nn);

    n0 = min(nn);

else

    n1 = max([d;ds]);

    n0 = min([d;ds]);

end

n = n1-n0+1;

T = zeros(n,n);

for i=n0:n1

    for j=n0:n1

        kd = d==i;

        kds = ds==j;

        T(i-n0+1,j-n0+1) = sum(kd.*kds);

    end

end

p = trace(T)/sum(T(:));
