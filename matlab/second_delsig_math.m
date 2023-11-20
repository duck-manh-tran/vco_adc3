% matlab mathematic model of second order noise shapping
OSR = 250;
OBG = 2.5;
f_sample = 24;      % sampling rate in Mega Hezt
fs = f_sample*10^6;
bw = fs/(2*OSR);


f_vco = [2.5 7]; f_dco = [2 11];   % profile_1: configure for 1-bit 1-phase
% f_vco = 5*[2.5 7]; f_dco = 5*[2 11];   % profile_1: configure for 1-bit 1-phase
% f_vco = [2.5 7]; f_dco = [2 11];   % profile_1: configure for 1-bit 1-phase



f_vco_norm = f_vco/f_sample;
f_dco_norm = f_dco/f_sample;
Vin_pp = 0.8;    % input voltage = 0.8 Vpp

Kv1 = (f_vco_norm(2)-f_vco_norm(1))/Vin_pp  ;  f0_1 = f_vco_norm(1);
Kv2 = (f_dco_norm(2)-f_dco_norm(1));  f0_2 = f_dco_norm(1);

Ac = [0 0; Kv2 0];
Bc = [Kv1 f0_1 -1; 0 f0_2 -1;];
Cc = [0 1];
Dc = [0 0 0];

sys_ct = ss(Ac, Bc, Cc, Dc);
sys_dt = c2d(sys_ct, 1);

f_sig = 0.2*fs/OSR
u = Vin_pp*sin(2*pi*(f_sig/fs)*(0:1:2^15));
K_offset = ones(1, length(u));
u_ = [u ; K_offset];
Ad = sys_dt.A;
Bd = sys_dt.B;
Cd = sys_dt.C;
Dd = sys_dt.D;

ABCD = [Ad Bd; Cd Dd];
[v,xn,xmax,y] = simulateDSM(u_, ABCD, 2, zeros(2,1));
v_norm = v - mean(v);

[P1, f] = periodogram(v_norm, blackmanharris(length(v), 'periodic'), length(v), fs);

figure(1)
plot (v(1000:1100))

figure(2);
P1_remove_offset = 10*log10(P1) - max(10*log10(P1));
plot (f, P1_remove_offset);
hold on;
tmp = -300:10:0;
bw = bw * ones(length(tmp));
plot (bw, tmp);
xlim([0 4e4]);