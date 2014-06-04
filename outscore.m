function ds = outscore(ds,score,options)
outp = 0;
if isfield(options,'output')
    outp = options.output;
end


switch outp
    case 1
        ds = score;
    case 2
        ds = [ds score];
end
