% [theta, phi] = MakeFSTGrid(bandwidth)
%
% Return a mesh of theta/phi coordinates suitable for evaluating a
% function of given bandwidth.
%
% Theta is the angle from the z-axis (0,pi).
% Phi is the angle in the xy-plane from the x-axis (0,2*pi).

% $Id: MakeFSTGrid.m 5 2008-07-24 21:10:13Z crodgers $

function [theta, phi] = MakeFSTGrid(bandwidth)

k=0:(2*bandwidth-1);
  
theta=pi*(2*k+1)/(4*bandwidth);
phi=pi*k/bandwidth;

[theta,phi]=meshgrid(theta,phi);
