function [new_voltages]=Synthesize_Voltages(V,Jappl,T,K)
% This function synthesizes voltage patterns one would get from an o.n. set of CPs (such as trig)
% given measured voltages from a set of measured data arising from orthogonal patterns with the
% same number of linearly independent vectors (patterns) as that of the desired set

% Variables:
% L        number of electrodes
% K        number of CPs
% V        measured voltages (could be complex), row is electrode number, column is CP, size L x K
% Jappl       applied currents (could be complex), row is electrode number, column is CP, size L x K
% T        desired orthonormal current patterns (real)

% new_voltages        synthesized complex voltages from CPs T, size L x K


% row is electrode number
% column is CP

% Let M be the linear operator that maps applied current patterns (a column
% of Jappl) to measured voltages (a column of V). We then have that
% M*Jappl=V. (Recall the kth of A*B is A applied to kth column of B.) Since
% Jappl is unitary (orthogonal in the real case), this implies that 
% M = V*Jappl'. Thus, the voltages measure had we applied currents in T are
% M*T = V*Jappl'*T

if T'*T ~= eye(K)
    err('Desired basis is not orthonormal.')
end

new_voltages = V*Jappl'*T;


