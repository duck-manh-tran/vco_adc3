v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
C {devices/code.sym} -10 -110 0 0 {name=phase_ext_digital only_toplevel=false value="
.subckt phase_extractor sink_out p4 p3 p2 p1 p0 pn4 pn3 pn2 pn1 pn0
a_ext_and0 [p0 pn1_b] ext0 and1
a_ext_and1 [p1 pn2_b] ext1 and1
a_ext_and2 [p2 pn3_b] ext2 and1
a_ext_and3 [p3 pn4_b] ext3 and1
a_ext_and4 [p4 pn0_b] ext4 and1

a_ext_inv0 pn1 pn1_b inv1
a_ext_inv1 pn2 pn2_b inv1
a_ext_inv2 pn3 pn3_b inv1
a_ext_inv3 pn4 pn4_b inv1
a_ext_inv4 pn0 pn0_b inv1

a_ext_or0 [ext2 ext3] net3 or1
a_ext_or1 [ext0 ext1] net4 or1
a_ext_or2 [ext4 GND ]  net5 or1
a_ext_or3 [net5 GND ]  net6 or1
a_ext_or4 [net4 net3] net7 or1
a_ext_or5 [net7 net6] sink_out or1

.model and1 d_and(rise_delay = 0.5e-9 fall_delay = 0.3e-9 input_load = 0.5e-12)
.model inv1 d_inverter(rise_delay = 0.5e-9 fall_delay = 0.3e-9 input_load = 0.5e-12)
.model or1 d_or(rise_delay = 0.5e-9 fall_delay = 0.3e-9 input_load = 0.5e-12)

.ends

*** adc_bridge blocks ***
aconverter [p0 p1 p2 p3 p4 pn0 pn1 pn2 pn3 pn4] [d_p0 d_p1 d_p2 d_p3 d_p4 d_pn0 d_pn1 d_pn2 d_pn3 d_pn4] adc1
.model adc1 adc_bridge (in_low='v_dd/2-5m' in_high='v_dd/2+5m' rise_delay=1.0e-12 fall_delay=1.0e-12)
"}
C {devices/ipin.sym} -40 -80 0 0 {name=p1 lab=xxx}
C {devices/opin.sym} 160 -60 0 0 {name=p2 lab=xxx}
