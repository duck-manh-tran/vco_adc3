v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 420 -510 420 -490 { lab=VDD}
N 155 -370 155 -330 { lab=VDD}
N 155 -270 155 -230 { lab=GND}
N 50 -270 50 -230 { lab=GND}
N 50 -370 50 -330 { lab=Anlg_in}
N 50 -455 50 -415 { lab=GND}
N 50 -555 50 -515 { lab=ENB}
N 360 -210 420 -210 { lab=Anlg_in}
N 140 -510 200 -510 { lab=ENB}
N 420 -230 420 -210 {
lab=Anlg_in}
N 480 -280 520 -280 {
lab=p[4]}
N 480 -320 520 -320 {
lab=p[3]}
N 480 -360 520 -360 {
lab=p[2]}
N 480 -400 520 -400 {
lab=p[1]}
N 480 -440 520 -440 {
lab=p[0]}
N 320 -280 360 -280 {
lab=pn[4]}
N 320 -320 360 -320 {
lab=pn[3]}
N 320 -360 360 -360 {
lab=pn[2]}
N 320 -400 360 -400 {
lab=pn[1]}
N 320 -440 360 -440 {
lab=pn[0]}
N 140 -550 200 -550 {
lab=VDD}
N 280 -550 330 -550 {
lab=pn[0]}
N 140 -610 200 -610 { lab=ENB}
N 140 -650 200 -650 {
lab=VDD}
N 280 -650 330 -650 {
lab=p[0]}
N 600 -570 620 -570 {
lab=p[0]}
N 600 -540 620 -540 {
lab=pn[1]}
N 750 -560 770 -560 {
lab=ext0}
N 600 -460 620 -460 {
lab=p[1]}
N 600 -430 620 -430 {
lab=pn[2]}
N 750 -450 770 -450 {
lab=ext1}
N 600 -350 620 -350 {
lab=p[2]}
N 600 -320 620 -320 {
lab=pn[3]}
N 750 -340 770 -340 {
lab=ext2}
N 600 -240 620 -240 {
lab=p[3]}
N 600 -210 620 -210 {
lab=pn[4]}
N 750 -230 770 -230 {
lab=ext3}
N 600 -130 620 -130 {
lab=p[4]}
N 600 -100 620 -100 {
lab=pn[0]}
N 750 -120 770 -120 {
lab=ext4}
C {devices/vdd.sym} 420 -510 0 0 {name=l11 lab=VDD}
C {devices/vsource.sym} 155 -300 0 0 {name=Vsup value="DC=v_dd"}
C {devices/vsource.sym} 50 -300 0 0 {name=Vground value="DC=v_a"}
C {devices/lab_wire.sym} 420 -210 0 0 {name=l12 sig_type=std_logic lab=Anlg_in
}
C {devices/vsource.sym} 50 -485 0 0 {name=Venb1 value="DC=0 PULSE( 0 v_dd 0 10n 10n 500n 1u 3 )"}
C {devices/vdd.sym} 155 -370 0 0 {name=l13 lab=VDD}
C {devices/gnd.sym} 155 -230 0 0 {name=l14 lab=GND}
C {devices/gnd.sym} 50 -230 0 0 {name=l15 lab=GND}
C {devices/gnd.sym} 50 -415 0 0 {name=l17 lab=GND}
C {devices/lab_pin.sym} 50 -350 2 0 {name=l18 sig_type=std_logic lab=Anlg_in}
C {devices/lab_pin.sym} 50 -535 0 0 {name=l19 sig_type=std_logic lab=ENB}
C {devices/code.sym} 10 -170 0 0 {name=control only_toplevel=false value="
.control
set nobreak
set num_threads=6
set test_mode = 0
* mode = 0: operation testing				1:  frequency extraction    2:  power consumption
if ($test_mode = 0)
    save "p[0]" "p[1]" "p[2]" "p[3]" "p[4]"  "pn[0]" "pn[1]" "pn[2]" "pn[3]" "pn[4]" enb sink_out d_ext0 d_ext1 d_ext2 d_ext3 d_ext4
    TRAN 5n 100u
    plot "p[0]"
    plot sink_out
    * MEAS TRAN prd TRIG p_buf[0] VAL=0.8 RISE=10 TARG p_buf[0] VAL=0.8 RISE=20
    * let freq = 10/prd
    * echo \\"frequency: \\"
    * print freq
    write 5s_ringOsc_tb.raw
    eprvcd sink_out d_ext0 d_ext1 d_ext2 d_ext3 d_ext4
end
if ($test_mode = 1)
    let Vlow = 0
    let Vlimit = 1.01     $ set upper bound for sweeping
    let Vsweep = 0.2      $ set step size for sweeping
    let NoPoints=(Vlimit-Vlow)/Vsweep+2    $ set number of points for sweeping
    let freq =unitvec(NoPoints)
    let Vin  =unitvec(NoPoints)
    let Vin[0]=Vlow
    let ix=0
    while Vin[ix] < Vlimit
        alter Vground DC=Vin[ix]
        TRAN 0.4n 12u
        MEAS TRAN prd TRIG pha_vco VAL=0.8 RISE=10 TARG pha_vco VAL=0.8 RISE =20
        let freq[ix] = 10/prd
        let ix = ix+1
        Let Vin[ix] = Vin[ix-1]+Vsweep
    end
   print Vin freq
end
if ($test_mode = 2)
    save \\"vdd\\" @Vsup[i] \\"p[0]\\"
    TRAN 0.1n 5u
    MEAS TRAN I_vco AVG @Vsup[i] FROM=3u TO=4u
    MEAS TRAN V_vco AVG vdd FROM=3u TO=4u
    let Power=I_vco*V_vco
    print Power
end
.endc
"}
C {devices/lab_wire.sym} 170 -510 0 0 {name=l1 sig_type=std_logic lab=ENB}
C {devices/code_shown.sym} 290 -160 0 0 {name=parameter only_toplevel=false value=
".param mc_mm_switch=0
.param L_main=1.2
.param L_aux=1.2
.param Wp=5
.param Wn=2
.param v_dd=1.2
.param v_a=0"}
C {5s_ringOsc.sym} 420 -360 0 0 {name=Xi_1 L_main=\\"L_main\\" L_aux=\\"L_aux\\" Wp=\\"Wp\\" Wn=\\"Wn\\"}
C {devices/lab_wire.sym} 490 -440 2 0 {name=l4 sig_type=std_logic lab=p[0]}
C {devices/lab_wire.sym} 350 -440 0 0 {name=l9 sig_type=std_logic lab=pn[0]}
C {devices/lab_wire.sym} 350 -400 0 0 {name=l10 sig_type=std_logic lab=pn[1]}
C {devices/lab_wire.sym} 350 -360 0 0 {name=l16 sig_type=std_logic lab=pn[2]}
C {devices/lab_wire.sym} 350 -320 0 0 {name=l20 sig_type=std_logic lab=pn[3]}
C {devices/lab_wire.sym} 350 -280 0 0 {name=l21 sig_type=std_logic lab=pn[4]}
C {sky130_fd_pr/corner.sym} 160 -170 0 0 {name=CORNER only_toplevel=false corner=tt}
C {sky130_stdcells/einvp_2.sym} 240 -550 0 0 {name=x1 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} 330 -550 0 0 {name=l2 sig_type=std_logic lab=pn[0]}
C {devices/vdd.sym} 140 -550 0 0 {name=l3 lab=VDD}
C {devices/code_shown.sym} 30 -20 0 0 {name=s1 only_toplevel=false value=".inc ~/git/caravel_user_project_analog/dependencies/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice"}
C {devices/lab_wire.sym} 490 -400 2 0 {name=l5 sig_type=std_logic lab=p[1]}
C {devices/lab_wire.sym} 490 -360 2 0 {name=l6 sig_type=std_logic lab=p[2]}
C {devices/lab_wire.sym} 490 -320 2 0 {name=l7 sig_type=std_logic lab=p[3]}
C {devices/lab_wire.sym} 490 -280 2 0 {name=l8 sig_type=std_logic lab=p[4]}
C {devices/lab_wire.sym} 170 -610 0 0 {name=l37 sig_type=std_logic lab=ENB}
C {sky130_stdcells/einvp_2.sym} 240 -650 0 0 {name=x8 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} 330 -650 0 0 {name=l41 sig_type=std_logic lab=p[0]}
C {devices/vdd.sym} 140 -650 0 0 {name=l42 lab=VDD}
C {devices/code.sym} 810 -150 0 0 {name=phase_sink only_toplevel=false value="
x_pe sink_out d_ext0 d_ext1 d_ext2 d_ext3 d_ext4 phase_extractor
.subckt phase_extractor sink_out ext0 ext1 ext2 ext3 ext4

a_ext_or0 [ext2 ext3] net3 or1
a_ext_or1 [ext0 ext1] net4 or1
a_ext_or2 [ext4 GND ] net5 or1
a_ext_or3 [net5 GND ] net6 or1
a_ext_or4 [net4 net3] net7 or1
a_ext_or5 [net7 net6] sink_out or1

.model and1 d_and(rise_delay = 0.5e-9 fall_delay = 0.3e-9 input_load = 0.5e-12)
.model inv1 d_inverter(rise_delay = 0.5e-9 fall_delay = 0.3e-9 input_load = 0.5e-12)
.model or1 d_or(rise_delay = 0.5e-9 fall_delay = 0.3e-9 input_load = 0.5e-12)

.ends

*** adc_bridge blocks ***
aconverter [ext0 ext1 ext2 ext3 ext4] [d_ext0 d_ext1 d_ext2 d_ext3 d_ext4] adc1
.model adc1 adc_bridge (in_low='v_dd/2-5m' in_high='v_dd/2+5m' rise_delay=1.0e-12 fall_delay=1.0e-12)
"}
C {phase_diff.sym} 640 -520 0 0 {name=x2}
C {devices/lab_wire.sym} 770 -560 2 0 {name=l24 sig_type=std_logic lab=ext0}
C {phase_diff.sym} 640 -410 0 0 {name=x3}
C {devices/lab_wire.sym} 770 -450 2 0 {name=l27 sig_type=std_logic lab=ext1}
C {phase_diff.sym} 640 -300 0 0 {name=x4}
C {devices/lab_wire.sym} 770 -340 2 0 {name=l30 sig_type=std_logic lab=ext2}
C {phase_diff.sym} 640 -190 0 0 {name=x5}
C {devices/lab_wire.sym} 770 -230 2 0 {name=l33 sig_type=std_logic lab=ext3}
C {phase_diff.sym} 640 -80 0 0 {name=x6}
C {devices/lab_wire.sym} 770 -120 2 0 {name=l36 sig_type=std_logic lab=ext4}
C {devices/lab_wire.sym} 600 -570 0 0 {name=l22 sig_type=std_logic lab=p[0]}
C {devices/lab_wire.sym} 600 -460 0 0 {name=l23 sig_type=std_logic lab=p[1]}
C {devices/lab_wire.sym} 600 -350 0 0 {name=l25 sig_type=std_logic lab=p[2]}
C {devices/lab_wire.sym} 600 -240 0 0 {name=l26 sig_type=std_logic lab=p[3]}
C {devices/lab_wire.sym} 600 -130 0 0 {name=l28 sig_type=std_logic lab=p[4]}
C {devices/lab_wire.sym} 600 -540 0 0 {name=l29 sig_type=std_logic lab=pn[1]}
C {devices/lab_wire.sym} 600 -430 0 0 {name=l31 sig_type=std_logic lab=pn[2]}
C {devices/lab_wire.sym} 600 -320 0 0 {name=l32 sig_type=std_logic lab=pn[3]}
C {devices/lab_wire.sym} 600 -100 0 0 {name=l34 sig_type=std_logic lab=pn[0]}
C {devices/lab_wire.sym} 600 -210 0 0 {name=l35 sig_type=std_logic lab=pn[4]}
C {devices/code.sym} 810 -310 0 0 {name=udc1 only_toplevel=false value="

"}
