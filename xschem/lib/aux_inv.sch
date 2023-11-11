v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
L 4 0 -300 0 0 {}
L 4 0 -300 220 -300 {}
L 4 220 -300 220 -0 {}
L 4 -0 -0 220 -0 {}
N 70 -210 70 -110 { lab=A}
N 110 -180 110 -140 { lab=Y}
N 110 -80 110 -40 { lab=VGND}
N 110 -270 110 -240 { lab=VPWR}
N 50 -160 70 -160 { lab=A}
N 110 -160 140 -160 { lab=Y}
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
