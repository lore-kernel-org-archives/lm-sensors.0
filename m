From: James Satterfield <james@uberduper.com>
Date: Sat, 28 Jul 2007 23:59:53 +0000
Subject: [lm-sensors] ASUS M2N-LR sensors reports incorrect values
Message-Id: <0F5CC51D-B270-4B1F-8CD1-29B13D9E7F7C@uberduper.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Motherboard: ASUS M2N-LR
Chip:  W83627THG-A
Sensors Version: 2.10.1
Kernel: 2.6.20

sensors output:
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
              +38=B0C
Core1 Temp:
              +43=B0C

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.94 V  (min =3D  +0.70 V, max =3D  +1.87 V)       ALARM
+12V:      +6.51 V  (min =3D  +9.67 V, max =3D  +1.52 V)       ALARM
+3.3V:     +1.44 V  (min =3D  +1.17 V, max =3D  +1.31 V)       ALARM
+5V:       +4.85 V  (min =3D  +2.51 V, max =3D  +0.45 V)       ALARM
-12V:      +0.22 V  (min =3D  -4.47 V, max =3D  +4.25 V)
V5SB:      +5.00 V  (min =3D  +2.53 V, max =3D  +3.14 V)       ALARM
VBat:      +0.82 V  (min =3D  +1.52 V, max =3D  +1.26 V)       ALARM
fan1:        0 RPM  (min =3D 3552 RPM, div =3D 2)              ALARM
CPU Fan:     0 RPM  (min =3D 337500 RPM, div =3D 2)              ALARM
fan3:        0 RPM  (min =3D 3590 RPM, div =3D 2)              ALARM
M/B Temp:    -48=B0C  (high =3D  +125=B0C, hyst =3D  -128=B0C)   sensor =3D=
 =20
thermistor
CPU Temp:  -48.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
 =20
thermistor
temp3:     -48.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
 =20
thermistor
alarms:
beep_enable:
           Sound alarm enabled


sensors-detect:
Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus nForce2 adapter at 2a00'
     Busdriver `i2c-nforce2', I2C address 0x50
     Chip `eeprom' (confidence: 6)
   * Bus `SMBus nForce2 adapter at 2a00'
     Busdriver `i2c-nforce2', I2C address 0x51
     Chip `eeprom' (confidence: 6)

   EEPROMs are *NOT* sensors! They are data storage chips commonly
   found on memory modules (SPD), in monitors (EDID), or in some
   laptops, for example.

Driver `k8temp' (should be inserted):
   Detects correctly:
   * ISA bus, undetermined address (Busdriver `i2c-isa')
     Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `w83627hf' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)


dmesg link: http://www.uberduper.com/~jsatter/lm-sensors/dmesg.txt

isadump 0x295 0x296:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
10: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 e0
20: ff 6b 59 b6 b9 8e f5 d0 ff ff ff f0 00 19 9f 52
30: 49 11 5e e9 7f 15 01 2f 1a 7d 80 be 02 bc 00 00
40: 03 00 00 fe ff 00 00 5f 1f 03 89 44 18 95 00 a3
50: ff ff 80 ff ff ff 00 80 90 70 ff ff 11 00 ff 05
60: ff 6b 59 b6 b9 8e f5 d0 ff ff ff f0 00 19 9f 52
70: 49 11 5e e9 7f 15 01 2f 1a 7d 80 be 02 bc 00 00
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
90: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 e0
a0: ff 6b 59 b6 b9 8e f5 d0 ff ff ff f0 00 19 9f 52
b0: 49 11 5e e9 7f 15 01 2f 1a 7d 80 be 02 bc 00 00
c0: 03 00 00 fe ff 00 00 5f 1f 03 89 44 18 95 00 a3
d0: ff ff 80 ff ff ff 00 80 90 70 ff ff 11 00 ff 05
e0: ff 6b 59 b6 b9 8e f5 d0 ff ff ff f0 00 19 9f 52
f0: 49 11 5e e9 7f 15 01 2f 1a 7d 80 be 02 bc 00 00

lsmod:
i2c_dev                 9992  0
vmnet                  42944  17
vmmon                1851628  7
appletalk              42992  0
cpufreq_conservative     9736  0
cpufreq_userspace       6176  0
cpufreq_stats           8416  0
cpufreq_powersave       3072  0
cpufreq_ondemand       10640  1
powernow_k8            16480  1
freq_table              6336  3 =20
cpufreq_stats,cpufreq_ondemand,powernow_k8
w83627hf               31760  0
hwmon_vid               4864  1 w83627hf
i2c_isa                 7680  1 w83627hf
eeprom                  9744  0
parport_pc             40104  0
lp                     15048  0
parport                43404  2 parport_pc,lp
serio_raw               9092  0
k8temp                  7552  0
i2c_nforce2             7680  0
i2c_core               26624  5 =20
i2c_dev,w83627hf,i2c_isa,eeprom,i2c_nforce2
psmouse                43536  0
pcspkr                  4736  0
shpchp                 37404  0
pci_hotplug            36228  1 shpchp
ipv6                  307072  14
evdev                  13056  0
tsdev                  10112  0
ext3                  143760  2
jbd                    68208  1 ext3
mbcache                11400  1 ext3
sg                     40616  0
sd_mod                 25092  2
ide_disk               18304  3
ide_cd                 35104  0
cdrom                  40744  1 ide_cd
sata_nv                24196  0
ata_generic            10628  0
libata                137000  2 sata_nv,ata_generic
generic                 6532  0 [permanent]
ehci_hcd               37004  0
3w_9xxx                38148  1
scsi_mod              166968  4 sg,sd_mod,libata,3w_9xxx
ohci_hcd               24196  0
tg3                   114308  0
usbcore               154416  3 ehci_hcd,ohci_hcd
amd74xx                16944  0 [permanent]
thermal                16912  0
processor              34952  2 powernow_k8,thermal
fan                     6536  0
fbcon                  44416  0
tileblit                4096  1 fbcon
font                    9856  1 fbcon
bitblit                 7296  1 fbcon
softcursor              3712  1 bitblit
vesafb                 10376  0
cfbcopyarea             5120  1 vesafb
cfbimgblt               4096  1 vesafb
cfbfillrect             5632  1 vesafb
capability              7048  0
commoncap               9472  1 capability



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
