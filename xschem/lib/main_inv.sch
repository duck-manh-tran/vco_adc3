v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
L 4 0 -300 0 0 {}
L 4 0 0 390 0 {}
L 4 0 -300 390 -300 {}
L 4 390 -300 670 -300 {}
L 4 670 -300 670 -0 {}
L 4 390 0 670 -0 {}
N 70 -210 70 -110 { lab=A}
N 110 -180 110 -140 { lab=Y}
N 110 -80 110 -40 { lab=VGND}
N 110 -270 110 -240 { lab=VPWR}
N 50 -160 70 -160 { lab=A}
N 110 -160 140 -160 { lab=Y}
N 230 -210 230 -110 { lab=A}
N 270 -180 270 -140 { lab=Y}
N 270 -80 270 -40 { lab=VGND}
N 270 -270 270 -240 { lab=VPWR}
N 210 -160 230 -160 { lab=A}
N 270 -160 300 -160 { lab=Y}
N 380 -210 380 -110 { lab=A}
N 420 -180 420 -140 { lab=Y}
N 420 -80 420 -40 { lab=VGND}
N 420 -270 420 -240 { lab=VPWR}
N 360 -160 380 -160 { lab=A}
N 420 -160 450 -160 { lab=Y}
N 530 -210 530 -110 { lab=A}
N 570 -180 570 -140 { lab=Y}
N 570 -80 570 -40 { lab=VGND}
N 570 -270 570 -240 { lab=VPWR}
N 510 -160 530 -160 { lab=A}
N 570 -160 600 -160 { lab=Y}
C {sky130_fd_pr/pfet3_01v8.sym} 90 -210 0 0 {name=M1
L=\\"L\\"
W=\\"Wp\\"
body=VDD
nf=1
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 90 -110 0 0 {name=M2
L=\\"L\\"
W=\\"Wn\\"
body=GND
nf=1
spiceprefix=X
}
C {devices/iopin.sym} 110 -270 0 0 {name=p1 lab=VPWR}
C {devices/iopin.sym} 110 -40 0 0 {name=p2 lab=VGND}
C {devices/ipin.sym} 50 -160 0 0 {name=p3 lab=A
}
C {devices/opin.sym} 140 -160 0 0 {name=p4 lab=Y}
C {sky130_fd_pr/pfet3_01v8.sym} 250 -210 0 0 {name=M3
L=\\"L\\"
W=\\"Wp\\"
body=VDD
nf=1
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 250 -110 0 0 {name=M4
L=\\"L\\"
W=\\"Wn\\"
body=GND
nf=1
spiceprefix=X
}
C {devices/lab_pin.sym} 210 -160 0 0 {name=p5 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 300 -160 2 0 {name=p6 sig_type=std_logic lab=Y}
C {devices/lab_pin.sym} 270 -270 2 0 {name=p7 sig_type=std_logic lab=VPWR}
C {devices/lab_pin.sym} 270 -40 2 0 {name=p8 sig_type=std_logic lab=VGND}
C {sky130_fd_pr/pfet3_01v8.sym} 400 -210 0 0 {name=M5
L=\\"L\\"
W=\\"Wp\\"
body=VDD
nf=1
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 400 -110 0 0 {name=M6
L=\\"L\\"
W=\\"Wn\\"
body=GND
nf=1
spiceprefix=X
}
C {devices/lab_pin.sym} 360 -160 0 0 {name=p9 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 450 -160 2 0 {name=p10 sig_type=std_logic lab=Y}
C {devices/lab_pin.sym} 420 -270 2 0 {name=p11 sig_type=std_logic lab=VPWR}
C {devices/lab_pin.sym} 420 -40 2 0 {name=p12 sig_type=std_logic lab=VGND}
C {sky130_fd_pr/pfet3_01v8.sym} 550 -210 0 0 {name=M7
L=\\"L\\"
W=\\"Wp\\"
body=VDD
nf=1
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 550 -110 0 0 {name=M8
L=\\"L\\"
W=\\"Wn\\"
body=GND
nf=1
spiceprefix=X
}
C {devices/lab_pin.sym} 510 -160 0 0 {name=p13 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 600 -160 2 0 {name=p14 sig_type=std_logic lab=Y}
C {devices/lab_pin.sym} 570 -270 2 0 {name=p15 sig_type=std_logic lab=VPWR}
C {devices/lab_pin.sym} 570 -40 2 0 {name=p16 sig_type=std_logic lab=VGND}
