% Short script to test InvFST_semi_fly_mex against a direct computation of
% the spherical harmonics.
%
% N.B. The timing compares evaluating the entire spherical harmonic
% decomposition for every coefficient and calculating the values directly
% for a SINGLE Y_l^m.

% $Id: TestInv.m 5 2008-07-24 21:10:13Z crodgers $

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

disp('Testing the inverse spherical Fourier transform code')

bandwidth=150;

[th,ph]=MakeFSTGrid(bandwidth);

for j=0:(bandwidth-1)
  for m=-j:j
    SphHRep=zeros(jm2idx(bandwidth-1,bandwidth-1),1);
    SphHRep(jm2idx(j,m))=1;
    
    tic,result=InvFST_semi_fly_mex(SphHRep2FSTRep(SphHRep));result_time=toc;
    tic,direct=Ylm(j,m,th,ph);direct_time=toc;
        
    fprintf(['j=%g, m=%g: error=%g\t\tInverse transform time = %g, Single ' ...
             'Ylm time = %g\n'],j,m,max(max(abs(result-direct))),result_time,direct_time)
  end
end
