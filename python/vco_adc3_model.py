import numpy as np
import scipy
import math
import matplotlib.pyplot as plt

# Behavioral model of multi-bit multi-phases 2nd delta-sigma vco-adc3

def main():
# ----------------- setup time for the simulation ----------------
	freq_vco = 5e6 * np.array([2, 9.6])			# Frequency range of the VCO
	freq_dco = 5e6 * np.array([3.8, 15])			# Frequency range of the DCO
	
	F_sample = 8e6;     # Over sampling frequency of ADC
	div = 80;               								# Time division coefficiency
	F_display = F_sample * div;                 								# Simulator frequency
	transient_time = 1.2e-3;  			# Transient time of simulation

# --------------------- vco-adc3 model description --------------------------

	t_s = np.arange( 0, transient_time, 1/F_sample, dtype=float);   	# Discrete time for samping periods
	t = np.arange( 0, transient_time, 1/F_display);         				# Simulator time 
	t = np.array(t[ 0 : (len(t_s) - 1) * div +1] ); 						# Get time in samples	
# ----- Input signal generator -----
	inputFreq = 5e3;			# frequency of input signal (Hz)
	inputAmp = 0.4;					# amplitude of input signal (V)
	Vinp =  inputAmp * np.cos( 2*math.pi * inputFreq*t );
# ------------- Init VCO, DCO phase, counters quantizer -----------
	phase_v = [0];
	pulse_v = [0];
	freq_v = [0];
	phase_d = [0];
	pulse_d = [0];
	freq_d = [0];
	udc1 = [0];
	udc2 = [0];
	trigger_v = [0];
	trigger_d = [0];
	qtz = [0];
	print("Number of samples: ", len(t_s))

##	Second-order noise-shapping implementation	
	for i in range(len(t_s)-1):
# Stage 1:
		Vin = np.array(Vinp[i*div:(i+1)*div]);
		[pulse, phase] = VCO_sig_gen( Vin, F_display, freq_vco, phase_v[-1], div); # Gen VCO phase in a sampled time
		phase_v = np.append( phase_v, phase );				# Merge new vco phase signal to the old one
		[cnt1, trig_sig] = counter(udc1[-1], pulse, pulse_v[-1]);
		trigger_v = np.append( trigger_v, trig_sig);
		udc1 = np.append( udc1, cnt1 );
		pulse_v = np.append( pulse_v, pulse );	
		
# Stage 2:
		k = cnt1 % 8;
		[pulse, phase, freq] = DCO_sig_gen(k, F_display, freq_dco, phase_d[-1], div);
		phase_d = np.append( phase_d, phase );				# Merge new dco phase signal to the old one
		[cnt, trig_sig] = counter(udc2[-1], pulse, pulse_d[-1]);
		trigger_d = np.append( trigger_d, trig_sig );
		udc2 = np.append( udc2, cnt );
		pulse_d = np.append( pulse_d, pulse );		
		freq_d = np.append( freq_d, freq )		

		qtz_tmp = udc2[-1];
		udc2[-1] = 0
		udc1[-1] = (udc1[-1] - qtz_tmp + abs(udc1[-1] - qtz_tmp))/2
		qtz = np.append (qtz, qtz_tmp)
		
	print(sum(qtz))
	print(len(pulse_v))
	print(len(t))

	plt.figure(1);
	plt.subplot(4, 1, 1)
	plt.plot(t, Vinp)	

	plt.subplot(4, 1, 2)
	plt.plot(t, pulse_v)
	plt.plot(t, trigger_v)
	plt.plot(t, udc1)	
	plt.grid()	

	plt.subplot(4, 1, 3)	
	plt.plot(t, pulse_d)
	plt.plot(t, trigger_d)
	plt.grid()	
	
	plt.subplot(4, 1, 4);
	plt.plot(t_s, qtz);	
	plt.grid();
	
	plt.figure(2);
	fft_cal(qtz, F_sample, 8192); 

	plt.show()

	print ("End of this program")	

def fft_cal (in_sig, F_samp, fft_window_length):
	L = fft_window_length;
	W_blackman = scipy.signal.windows.blackmanharris(L);
	fft_input = in_sig[20:L+20];
	
	fft_input_window = fft_input * W_blackman ;
	Y_adc = scipy.fftpack.fft(fft_input_window);
	P2_adc = np.array( abs(Y_adc/L) );
	print ( P2_adc )
	print ( len(P2_adc) )
	P1_adc = np.array( P2_adc[ 0 : int(L/2) ] );
	P1_adc[1:-1] = 2 * P1_adc[1:-1];
	P1_adc[0] = P1_adc[1];
	P1_adc_db = 10*np.log(P1_adc) - max(10*np.log(P1_adc));
	
	f = F_samp * np.arange(0, L/2, 1, dtype=int) / L;
	plt.semilogx(f, P1_adc_db); 
	plt.grid();


def DCO_sig_gen(D_val, Fs_dis, freq_f0, i_phase, L):
	number_of_levels = 8; 		# 8-bit DCO
	freq_max = freq_f0[1];
	freq_min = freq_f0[0];
	freq_step = (freq_max - freq_min)/(number_of_levels-1);
	dco_freq = D_val * freq_step + freq_min;
	# Caculate the phase of VCO for the next sampling time
	delta_phase = dco_freq * (1/Fs_dis);
	phase = np.array([i_phase +  delta_phase[0]]);
	A = np.empty(L-1) * np.nan;
	phase = np.concatenate((phase, A), axis=0);
	for i in range (1, L):
		phase[i] = phase[i-1] + delta_phase[i];
	phase = phase % 1;
	pulse = np.array(list(map(int, 2*phase))); 
	return [pulse, phase, dco_freq]

def counter (cnt_val, signal, ref):
	signal_1 = np.append(signal, [0]);
	if ref == 0:
		signal_2 = np.append([0], signal);
	if ref == 1:
		signal_2 = np.append([1], signal);
	trig_sig = signal_1 - signal_2;
	trig_sig = (trig_sig + abs(trig_sig))/2;
	trig_sig = trig_sig[0:-1];
	L = len(trig_sig);
	counter = np.array([cnt_val+trig_sig[0]]);
	A = np.empty(L-1) * np.nan;
	counter = np.concatenate((counter, A), axis=0);
	for ic in range(1, L):
		counter[ic] = counter[ic-1] + trig_sig[ic]
	return [counter, trig_sig]

def VCO_sig_gen(Vin, Fs_dis, freq_f0, i_phase, L):
	Vpp = 0.8;
	Vin = Vin + 0.4;
	top_freq = freq_f0[1];
	bot_freq = freq_f0[0];
	kv = (top_freq - bot_freq)/Vpp;
	f0 = bot_freq;
	vco_freq = Vin * kv + f0;
	# Caculate the phase of VCO for the next sampling time
	delta_phase = vco_freq * (1/Fs_dis);
	phase = np.array([i_phase +  delta_phase[0]]);
	A = np.empty(L-1) * np.nan;
	phase = np.concatenate((phase, A), axis=0);
	for i in range (1, L):
		phase[i] = phase[i-1] + delta_phase[i];
	phase = phase % 1;
	pulse = np.array(list(map(int, 2*phase))); 
	return [pulse, phase]

	

main();

