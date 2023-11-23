v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 80 -10 100 -10 {
lab=#net1}
N -20 -10 0 -10 {
lab=B}
N -20 -50 100 -50 {
lab=A}
N 220 -30 240 -30 {
lab=out}
C {sky130_stdcells/and2_2.sym} 160 -30 0 0 {name=x_ext_and VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_2.sym} 40 -10 0 0 {name=x_ext_inv VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/ipin.sym} -20 -50 0 0 {name=p1 lab=A}
C {devices/ipin.sym} -20 -10 0 0 {name=p2 lab=B}
C {devices/opin.sym} 240 -30 0 0 {name=p3 lab=X}
