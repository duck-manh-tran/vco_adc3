v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -240 50 -200 50 {
lab=p[4:0]}
N -120 50 -80 50 {
lab=p_buf[4:0]}
N -240 130 -200 130 {
lab=pn[4:0]}
N -120 130 -80 130 {
lab=pn_buf[4:0]}
N -230 -210 -210 -210 {
lab=#net1}
N -330 -210 -310 -210 {
lab=pn_buf[1:4]}
N -330 -250 -210 -250 {
lab=p_buf[0:3]}
N -90 -230 -70 -230 {
lab=ext[0:3]}
N -230 -60 -210 -60 {
lab=#net2}
N -330 -60 -310 -60 {
lab=pn_buf[0]}
N -330 -100 -210 -100 {
lab=p_buf[4]}
N -90 -80 -70 -80 {
lab=ext[4]}
N 190 -140 210 -140 {
lab=#net3}
N 50 -240 70 -240 {
lab=ext[0]}
N 50 -200 70 -200 {
lab=ext[1]}
N 50 -160 70 -160 {
lab=ext[2]}
N 50 -120 70 -120 {
lab=ext[3]}
N 50 -80 70 -80 {
lab=ext[4]}
N 190 -220 210 -220 {
lab=#net4}
N 210 -220 210 -200 {
lab=#net4}
N 210 -200 230 -200 {
lab=#net4}
N 210 -160 210 -140 {
lab=#net3}
N 210 -160 230 -160 {
lab=#net3}
N 50 -40 70 -40 {
lab=GND}
N 50 -40 50 -20 {
lab=GND}
N 190 -60 210 -60 {
lab=#net5}
N 210 -80 210 -60 {
lab=#net5}
N 210 -80 230 -80 {
lab=#net5}
N 210 -40 230 -40 {
lab=GND}
N 210 -40 210 -20 {
lab=GND}
N 350 -60 370 -60 {
lab=#net6}
N 350 -180 370 -180 {
lab=#net7}
N 370 -180 370 -140 {
lab=#net7}
N 370 -140 390 -140 {
lab=#net7}
N 370 -100 370 -60 {
lab=#net6}
N 370 -100 390 -100 {
lab=#net6}
N 510 -120 530 -120 {
lab=sink_out}
C {sky130_stdcells/buf_2.sym} -160 50 0 0 {name=xbuf1[4:0] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/buf_2.sym} -160 130 0 0 {name=xbuf2[4:0] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} -210 50 0 0 {name=l22 sig_type=std_logic lab=p[4:0]}
C {devices/lab_wire.sym} -200 130 0 0 {name=l23 sig_type=std_logic lab=pn[4:0]}
C {devices/lab_wire.sym} -110 50 2 0 {name=l24 sig_type=std_logic lab=p_buf[4:0]}
C {devices/lab_wire.sym} -110 130 2 0 {name=l25 sig_type=std_logic lab=pn_buf[4:0]}
C {sky130_stdcells/and2_2.sym} -150 -230 0 0 {name=x_ext_and[0:3] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_2.sym} -270 -210 0 0 {name=x_ext_inv[0:3] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} -300 -250 0 0 {name=l26 sig_type=std_logic lab=p_buf[0:3]}
C {devices/lab_wire.sym} -320 -210 0 0 {name=l27 sig_type=std_logic lab=pn_buf[1:4]}
C {devices/lab_wire.sym} -70 -230 2 0 {name=l28 sig_type=std_logic lab=ext[0:3]}
C {sky130_stdcells/and2_2.sym} -150 -80 0 0 {name=x_ext_and1[4] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_2.sym} -270 -60 0 0 {name=x_ext_inv2[4] VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} -300 -100 0 0 {name=l29 sig_type=std_logic lab=p_buf[4]}
C {devices/lab_wire.sym} -320 -60 0 0 {name=l30 sig_type=std_logic lab=pn_buf[0]}
C {devices/lab_wire.sym} -70 -80 2 0 {name=l31 sig_type=std_logic lab=ext[4]}
C {sky130_stdcells/or2_2.sym} 130 -140 0 0 {name=x3 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/lab_wire.sym} 50 -240 0 0 {name=l32 sig_type=std_logic lab=ext[0]}
C {devices/lab_wire.sym} 50 -200 0 0 {name=l33 sig_type=std_logic lab=ext[1]}
C {devices/lab_wire.sym} 50 -160 0 0 {name=l34 sig_type=std_logic lab=ext[2]}
C {devices/lab_wire.sym} 50 -120 0 0 {name=l35 sig_type=std_logic lab=ext[3]}
C {devices/lab_wire.sym} 50 -80 0 0 {name=l36 sig_type=std_logic lab=ext[4]}
C {sky130_stdcells/or2_2.sym} 130 -220 0 0 {name=x2 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/or2_2.sym} 130 -60 0 0 {name=x4 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/or2_2.sym} 290 -180 0 0 {name=x5 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/gnd.sym} 50 -20 0 0 {name=l38 lab=GND}
C {sky130_stdcells/or2_2.sym} 290 -60 0 0 {name=x6 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/gnd.sym} 210 -20 0 0 {name=l39 lab=GND}
C {sky130_stdcells/or2_2.sym} 450 -120 0 0 {name=x7 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/ipin.sym} -240 50 0 0 {name=p1 lab=p[4:0]}
C {devices/ipin.sym} -240 130 0 0 {name=p2 lab=pn[4:0]}
C {devices/opin.sym} 530 -120 0 0 {name=p3 lab=sink_out}
