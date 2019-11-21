clear all
load('Data/Sphere64_Target1_measurements.mat') % Load simulated data
load('Data/electrodeCenters64.mat') % Load electrode center information 
L=numElectrodes; % Number of electrodes used
numCP=numInj; % Number of current patterns
skip=0; % skip pattern simulated
CurrAmp=IAmplitude; % Simulated current amplitude, if produced by Jussi
neg_angles=find(azimuth<0); % azimuth is related to phi (azi. listed from -pi:pi)
azimuth(neg_angles)=azimuth(neg_angles)+2*pi; % Shift original (-pi,0) to our (pi,2pi)
phi_elec=azimuth; % electrode azimuthal angles now in (0,2pi)
theta_elec=pi/2-elevation; % I believe Jussi's elevation (-pi/2,pi/2) is the complement of theta
th=theta_elec;
ph=phi_elec;
% h_th=pi/63;
% th=0:h_th:pi;
% h_ph=2*pi/64;
% ph=0:h_ph:2*pi;
% ph(end)=[];
pat=1;
CP=zeros(L,numCP);
max_ell_for_CP=ceil(sqrt(L));
for ll=0:max_ell_for_CP 
        for mm=-ll:ll
            CP(:,pat)=CurrAmp*Ylm(ll,mm,th,ph);
            pat=pat+1;
        end
end
RCP=real(CP); % real parts of spherical harmonics
ICP=imag(CP);  % imag parts of spherical harmonics
[CP_rref,piv]=rref(CP, 1e-16); % Find lin. ind cols of CP
[RCP_rref,pivR]=rref(RCP, 1e-16); % Find lin. ind cols of RCP
[ICP_rref,pivI]=rref(ICP, 1e-16); % Find lin. ind cols of ICP
CP_LI=CP(:,piv); % Linearly independent complex Sph.H. patterns
RCP_LI=RCP(:,pivR); % Linearly independent real Sph.H. patterns
ICP_LI=ICP(:,pivI); % Linearly independent imaginary Sph.H. patterns
% % Remove complex patterns that sum >0
% TEST=zeros(1,size(CP_LI,2));
% for ii=1:size(CP_LI,2)
%     TEST(ii)=sum(sin(theta_elec).*CP_LI(:,ii));
% end
% CP0=find(abs(TEST)<10^-13);
% CP_C=CP_LI(:,CP0);
% % Remove real patterns that sum >0
% RTEST=zeros(1,size(RCP_LI,2));
% for ii=1:size(RCP_LI,2)
%     RTEST(ii)=sum(sin(theta_elec).*RCP_LI(:,ii));
% end
% R0=find(abs(RTEST)<10^-13);
% RCP_LI_n0=RCP_LI(:,R0);
% size(RCP_LI_n0)
% % Remove imaginary patterns that sum >0
% ITEST=zeros(1,size(ICP_LI,2));
% for ii=1:size(ICP_LI,2)
%     ITEST(ii)=sum(sin(theta_elec).*ICP_LI(:,ii));
% end
% I0=find(abs(ITEST)<10^-13);
% ICP_LI_n0=ICP_LI(:,I0);
% size(ICP_LI_n0)
CP_RI=[RCP_LI,ICP_LI];
% spy(rref(CP_LI_n0))
QRI=CP_RI.'*CP_RI;
maskRI=find(abs(QRI)<10^-14);
QRI(maskRI)=0;
QC=CP_LI'*(sin(theta_elec).*CP_LI);
maskC=find(abs(QC)<10^-13);
QC(maskC)=0;
bool=round(ICP_rref,10)