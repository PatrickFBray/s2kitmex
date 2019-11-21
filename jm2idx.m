% [idx] = jm2idx(j,m)
%
% Array index for angular momenta, packing them in order first of increasing
% j, and then within each value of j, in increasing order of m. j>=0,
% j>=m>=-j.

% $Id: jm2idx.m 4046 2011-04-01 17:31:24Z crodgers $

% Copyright: Chris Rodgers, Aug, 2005.
%
% This file is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This file is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this file; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
% See the accompanying LICENSE file for details.

function [idx]=jm2idx(jval,mval)

if numel(jval)==1 % jval is a scalar --> duplicate to mval's size
    jval=repmat(jval,size(mval));
elseif numel(mval)==1 % same for mval
    mval=repmat(mval,size(jval));
end

% Check that the inputs are the right size
if numel(size(jval)) ~= numel(size(mval)) || ...
      any(size(jval) ~= size(mval))
  error('j and m must be the same size OR one must be a scalar!')
end

idx=zeros(size(jval));

for elemdx=1:numel(jval)
  if fix(jval(elemdx))~=jval(elemdx) || jval(elemdx)<0
    error('Bad value for j')
  elseif fix(mval(elemdx))~=mval(elemdx) || abs(mval(elemdx))>jval(elemdx)
    error('Bad value for m')
  end
  
  idx(elemdx)=(jval(elemdx)+1)^2 + mval(elemdx) - jval(elemdx);
end
