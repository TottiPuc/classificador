function plotfeatures(X,d,Xn)

m = size(X,2);

dmin = min(d);
dmax = max(d);

col = 'gbrcmykbgrcmykbgrcmykbgrcmykgbrcmykbgrcmykbgrcmykbgrcmykgbrcmykbgrcmykbgrcmykbgrcmyk';
mar = 'ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^';
clf
if (m<4)
    switch m
        case 1
            for k = dmin:dmax
                [h,x] = hist(X(d==k),100);
                dx = x(2)-x(1);
                A = sum(h)*dx;
                x = [x(1)-dx x x(end)+dx];
                h = [0 h 0];
                plot(x,h/A,col(k+1));
                hold on
            end
        case 2
            for k = dmin:dmax
                ii = find(d==k);
                plot(X(ii,1),X(ii,2),[col(k+1) mar(k+1)]);
                hold on
            end
        case 3
            for k = dmin:dmax
                ii = find(d==k);
                plot3(X(ii,1),X(ii,2),X(ii,3),[col(k+1) mar(k+1)]);
                hold on
            end
    end
else
    l = 1;
    for j=1:m
        for i=1:m
            zi = X(:,i);
            zj = X(:,j);
            subplot(m,m,l); l = l+1;

            for k = dmin:dmax
                ii = find(d==k);
                plot(zi(ii),zj(ii),[col(k+1) mar(k+1)]);
                hold on
                if scflag
                    for ic=1:length(ii)
                        text(zi(ii(ic)),zj(ii(ic)),['  ' num2str(sc(ii(ic)))]);
                    end
                end
                
            end
            if i==1
                ylabel(yl)
            end
            if j==m
                xlabel(xl)
            end
        end
    end


end
