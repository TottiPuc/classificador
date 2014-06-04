 %#########  Christian Arcos  ########### 
%######  distributor of parameters  #########
 %#######   CETUC - PUC - RIO  ##########

function [train, test, X, d, Xt, options] = distributor(varargin)

train = 0;
test = 0;

switch nargin
    case 2       % testing only
        X       = [];
        d       = [];
        Xt      = varargin{1};
        options = varargin{2};
        test    = 1;
    case 3       % training only
        X       = varargin{1};
        d       = double(varargin{2});
        Xt      = [];
        options = varargin{3};
        train   = 1;
    case 4     % training & test
        X       = varargin{1};
        d       = double(varargin{2});
        Xt      = varargin{3};
        options = varargin{4};
        test    = 1;
        train   = 1;
    otherwise
        error('Bcl_construct: number of input arguments must be 2, 3 or 4.');
end

