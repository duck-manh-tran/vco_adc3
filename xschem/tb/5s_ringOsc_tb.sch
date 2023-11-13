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
lab=p4}
N 480 -320 520 -320 {
lab=p3}
N 480 -360 520 -360 {
lab=p2}
N 480 -400 520 -400 {
lab=p1}
N 480 -440 520 -440 {
lab=p0}
N 320 -280 360 -280 {
lab=pn4}
N 320 -320 360 -320 {
lab=pn3}
N 320 -360 360 -360 {
lab=pn2}
N 320 -400 360 -400 {
lab=pn1}
N 320 -440 360 -440 {
lab=pn0}
N 140 -550 200 -550 {
lab=VDD}
N 280 -550 330 -550 {
lab=pn0}
C {devices/vdd.sym} 420 -510 0 0 {name=l11 lab=VDD}
C {devices/vsource.sym} 155 -300 0 0 {name=Vsup value="DC=v_dd"}
C {devices/vsource.sym} 50 -300 0 0 {name=Vground value="DC=v_a"}
C {devices/lab_wire.sym} 420 -210 0 0 {name=l12 sig_type=std_logic lab=Anlg_in
}
C {devices/vsource.sym} 50 -485 0 0 {name=Venb1 value="DC=0 PULSE( 0 v_dd 0 1n 1n 200n 1)"}
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
    save all
    TRAN 10n 500u
    plot p0
    MEAS TRAN prd TRIG p0 VAL=0.8 RISE=10 TARG p0 VAL=0.8 RISE=20
    let freq = 10/prd
    echo \\"frequency: \\"
    print freq
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
.param v_a=0.4"}
C {5s_ringOsc.sym} 420 -360 0 0 {name=Xi_1 L_main=\\"L_main\\" L_aux=\\"L_aux\\" Wp=\\"Wp\\" Wn=\\"Wn\\"}
C {devices/lab_wire.sym} 520 -440 2 0 {name=l4 sig_type=std_logic lab=p0}
C {devices/lab_wire.sym} 520 -400 2 0 {name=l5 sig_type=std_logic lab=p1}
C {devices/lab_wire.sym} 520 -360 2 0 {name=l6 sig_type=std_logic lab=p2}
C {devices/lab_wire.sym} 520 -320 2 0 {name=l7 sig_type=std_logic lab=p3}
C {devices/lab_wire.sym} 520 -280 2 0 {name=l8 sig_type=std_logic lab=p4}
C {devices/lab_wire.sym} 320 -440 0 0 {name=l9 sig_type=std_logic lab=pn0}
C {devices/lab_wire.sym} 320 -400 0 0 {name=l10 sig_type=std_logic lab=pn1}
C {devices/lab_wire.sym} 320 -360 0 0 {name=l16 sig_type=std_logic lab=pn2}
C {devices/lab_wire.sym} 320 -320 0 0 {name=l20 sig_type=std_logic lab=pn3}
C {devices/lab_wire.sym} 320 -280 0 0 {name=l21 sig_type=std_logic lab=pn4}
C {sky130_fd_pr/corner.sym} 160 -170 0 0 {name=CORNER only_toplevel=false corner=tt}
C {sky130_stdcells/einvp_2.sym} 240 -550 0 0 {name=x1 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} 330 -550 0 0 {name=l2 sig_type=std_logic lab=pn0}
C {devices/vdd.sym} 140 -550 0 0 {name=l3 lab=VDD}
C {devices/code_shown.sym} 30 -20 0 0 {name=s1 only_toplevel=false value=".inc ~/git/caravel_user_project_analog/dependencies/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice"}
