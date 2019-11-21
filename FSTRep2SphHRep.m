% [SphHRep] = FSTRep2SphHRep(FSTRep)
%
% Convert a list of spherical harmonic coefficients between my SphHRep
% format and the S2Kit library format.

% $Id: FSTRep2SphHRep.m 5 2008-07-24 21:10:13Z crodgers $

function [SphHRep] = FSTRep2SphHRep(FSTRep)
  
SphHRep=zeros(size(FSTRep));

maxj=idx2jm(numel(FSTRep));

idx=1;
for m=[0:maxj -maxj:-1]
  for j=abs(m):maxj
    SphHRep(jm2idx(j,m))=FSTRep(idx);
    idx=idx+1;
  end
end
