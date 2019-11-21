% [j,m] = idx2jm(idx)
%
% Reverse array index for angular momenta, packing them in order first of
% increasing j, and then within each value of j, in increasing order of
% m. j>=0, j>=m>=-j.

% $Id: idx2jm.m 4046 2011-04-01 17:31:24Z crodgers $

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

function [jval,mval]=idx2jm(idx)

jval=zeros(size(idx));
mval=zeros(size(idx));

for elemdx=1:numel(idx)
  if fix(idx(elemdx))~=idx(elemdx) || idx(elemdx)<1
    error('Bad value for idx')
  end

  jval(elemdx)=ceil(sqrt(idx(elemdx)))-1;
  
  mval(elemdx)=idx(elemdx)-(jval(elemdx)+1)^2+jval(elemdx);
end
