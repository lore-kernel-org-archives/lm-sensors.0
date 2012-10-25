From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Oct 2012 23:49:01 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20121025234901.GA4445@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
To: lm-sensors@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 09:07:36PM +0200, Jean Delvare wrote:
> On Thu, 25 Oct 2012 19:26:45 +0200, Harald Judt wrote:
> > Am 24.10.2012 21:23, schrieb Jean Delvare:
> > > To be really sure, it would be good if you could set arbitrary non-ze=
ro
> > > limits to in1, in4, in5 etc. otherwise we can't be sure these limits
> > > have been restored either.
> >=20
> > Good idea. Here is the corresponding part of my adjusted=20
> > /etc/sensors3.conf file:
> >=20
> > chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
> >=20
> >      label in0 "Vcore"
> >      label in2 "AVCC"
> >      label in3 "+3.3V"
> >      label in7 "3VSB"
> >      label in8 "Vbat"
> >=20
> >      set in0_min  0.5 * 1.00
> >      set in0_max  2.0 * 1.00
> >      set in1_min  1.6 * 1.00
> >      set in1_max  1.95 * 1.00
> >      set in2_min  2.0 * 1.00
> >      set in2_max  3.5 * 1.00
> >      set in3_min  2.0 * 1.00
> >      set in3_max  3.5 * 1.00
> >      set in4_min  0.8 * 1.00
> >      set in4_max  1.2 * 1.00
> >      set in5_min  1.5 * 1.00
> >      set in5_max  1.95 * 1.00
> >      set in7_min  2.0 * 1.00
> >      set in7_max  3.5 * 1.00
> >      set in8_min  2.0 * 1.00
> >      set in8_max  3.5 * 1.00
> >=20
> > There are some limits for min/max values, e.g. in5_max will get reset t=
o=20
> > 2.04 if you try to use a higher value. Therefore I've set it to 0.95 to=
=20
> > avoid any confusion.
> >=20
> > So, here are the results after sensors -s:
> >=20
> > nct6776-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.96 V  (min =3D  +0.50 V, max =3D  +2.00 V)
> > in1:           +1.84 V  (min =3D  +1.60 V, max =3D  +1.95 V)
> > AVCC:          +3.34 V  (min =3D  +2.00 V, max =3D  +3.50 V)
> > +3.3V:         +3.34 V  (min =3D  +2.00 V, max =3D  +3.50 V)
> > in4:           +1.05 V  (min =3D  +0.80 V, max =3D  +1.20 V)
> > in5:           +1.68 V  (min =3D  +1.50 V, max =3D  +1.95 V)
> > 3VSB:          +3.47 V  (min =3D  +2.00 V, max =3D  +3.50 V)
> > Vbat:          +3.31 V  (min =3D  +2.00 V, max =3D  +3.50 V)
> >=20
> > And after resume:
> > nct6776-isa-0290
> > Adapter: ISA adapter
> > Vcore:         +0.96 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > AVCC:          +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > +3.3V:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in4:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> > 3VSB:          +3.47 V  (min =3D  +2.00 V, max =3D  +3.50 V)
> > Vbat:          +3.31 V  (min =3D  +2.00 V, max =3D  +3.50 V)
> >=20
> > Apparently, in0-in5 do not get restored, only in7 and in8 do. There is =

> > no in6 on this chip (verified by looking in /sys/class/hwmon).
>=20
> I don't get it. I have double checked my code and I don't see how this
> is possible. Plus Guenter's testing was successful...
>=20
Doesn't work for me either on NCT6776F. Some of the data is restored, which=
 is
not the case if I use the "old" driver, so I must have used the correct dri=
ver.

sensors before restore:

nct6776-isa-0290
Adapter: ISA adapter
Vcore:         +0.78 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.02 V  (min =3D  +0.90 V, max =3D  +1.10 V)
AVCC:          +3.42 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.42 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +1.02 V  (min =3D  +0.90 V, max =3D  +1.10 V)
3VSB:          +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.60 V)
fan1:          840 RPM  (min =3D  500 RPM)
fan2:         1074 RPM  (min =3D 1000 RPM)
fan3:            0 RPM  (min =3D    0 RPM)  ALARM
fan4:            0 RPM  (min =3D    0 RPM)  ALARM
fan5:            0 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
CPUTIN:        +92.0=B0C  (high =3D +81.0=B0C, hyst =3D +76.0=B0C)  ALARM  =
sensor =3D
thermistor
AUXTIN:        +89.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor =3D
thermistor
PECI Agent 0:  +34.5=B0C
cpu0_vid:     +2.050 V
intrusion0:   OK
intrusion1:   OK

sensors after restore:

nct6776-isa-0290
Adapter: ISA adapter
Vcore:         +0.88 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.42 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
+3.3V:         +3.42 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in4:           +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.60 V)
fan1:          858 RPM  (min =3D  500 RPM)
fan2:         1210 RPM  (min =3D 1000 RPM)
fan3:            0 RPM  (min =3D    0 RPM)  ALARM
fan4:            0 RPM  (min =3D    0 RPM)  ALARM
fan5:            0 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
CPUTIN:        +91.5=B0C  (high =3D +81.0=B0C, hyst =3D +76.0=B0C)  ALARM  =
sensor =3D
thermistor
AUXTIN:        +89.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor =3D
thermistor
PECI Agent 0:  +35.0=B0C
cpu0_vid:     +2.050 V
intrusion0:   OK
intrusion1:   OK

Before and after register dumps are attached.

Guenter

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=before-suspend

superiotool r4.0-2834-gdef50b0
Found Nuvoton NCT6776F (C) (id=0xc333) at 0x2e
Register dump:
idx 10 11 13 14 16 17 18 19  1a 1b 1c 1d 1e 1f 20 21  22 23 24 25 26 27 28 2a  2b 2c 2d 2e 2f
val ff ff ff ff ff ff ff ff  c0 68 03 00 ff ff c3 33  ff 00 20 00 00 00 00 68  08 80 00 00 03
def ff ff 00 00 ff ff ff ff  f0 78 00 00 ff ff c3 33  ff 00 64 00 MM 00 00 c0  00 81 00 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 0e 00 ff  00 00
def 01 03 f0 06 02 0e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0 f2
val 01 03 f8 04 00 00
def 01 03 f8 04 00 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1 f2
val 00 02 f8 03 00 00 00
def 01 02 f8 03 00 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 82
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70 f0 f1 f2 f3
val 00 03 e0 0b 08 09 32 00
def 00 00 00 00 08 09 32 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 00 ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff
def 03 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1, GPIOA)
idx 30 60 61 e0 e1 e2 e3 e4  f0 f1 f2 f3 f4 f5 f6 f7
val 00 00 00 ff ff ff ff ff  73 5b 00 00 00 ff 00 ff
def 02 00 00 ff 00 00 00 ef  ff 00 00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val 0e ef 10 00 00 f7 00 00  00 ff 00 00 ff ff ff ff  ff ff ff ff ff 00
def 04 df 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee f0 f2 f3 f4 f6 f7  fe
val 01 00 00 00 00 06 1c 01  00 00 00 5d 00 00 00 c0  00
def 01 00 00 00 00 02 1c 00  00 00 00 00 00 00 00 c0  00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 e0 e1  e2 f0 f1 f2 f5 f6 f7 f8  f9 fa
val 01 02 90 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
def 00 00 00 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
LDN 0x0d (VID)
idx e0 e1 e2 e3 e4 e5 e6 e9  ee ef f0 f4 f5
val 00 00 00 00 00 00 00 00  88 00 00 00 00
def 00 00 00 00 00 00 00 00  88 00 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 00 00 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f1 f2
val 7f df ff fe f6 ff ff d3  ff 9f 9d 00 00
def ff df ff fe f6 ff ff d3  ff 9f 00 00 00
LDN 0x14 (SVID)
idx e0 e1 e3 e4
val 00 80 00 00
def 00 80 00 00
LDN 0x16 (Deep Sleep)
idx 30 e0 e1 e2
val 20 20 04 05
def 20 20 04 05
LDN 0x17 (GPIOA)
idx e0 e1 e2 e3 e4 e5
val ff ff ff ff 01 ff
def 01 00 00 00 01 00
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 a3 04 5a 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 a3 00 a3 5a a3 ff ff 50 00 00 00 00 84 00 00 
02: 6b 7f d6 d5 80 ff 1d 20 ff ff ff da 00 8a 71 e3 
03: ba e3 ba 8a 71 ff e1 00 00 50 4b ff ff ff ff ff 
04: 01 00 00 df ff 00 3f ff 2d ff ff ff 18 05 00 a3 
05: ff ff ff ff ff ff ff ff c1 ff ff ff ff 01 00 ff 
06: 00 ff ff ff ff 01 07 ff ff ff ff ff ff ff ff ff 
07: 00 0a 00 22 00 22 00 22 00 ff ff ff ff ff ff ff 
08: ff 03 1f 0f ff 3c 3c 3c 00 00 00 00 00 00 00 00 
09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4 
0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 01 01 
0b: 00 00 00 00 00 00 32 00 1c 00 00 34 28 80 c4 ff 
0c: 01 00 00 00 00 00 00 00 00 0e 06 ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0c 00 40 01 01 01 01 3c ff a3 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 1e 46 46 46 ff ff 99 ff ff ff ff ff ff ff ff 
03: ff 00 ff ff 00 4b ff ff 02 01 00 00 00 00 00 00 
04: ff ff ff ff ff 49 03 ff ff ff ff ff ff ff 01 ff 
05: 5c 80 02 4c 00 51 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0c 32 40 01 01 01 01 3c ff 5a ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 14 41 46 46 ff ff 33 b2 ff ff ff ff ff ff ff 
03: ff 00 ff ff 00 4b ff ff 02 01 00 00 00 00 00 00 
04: ff ff ff ff ff 06 04 ff ff ff ff ff ff ff 02 ff 
05: 59 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0c 00 40 01 01 01 01 3c ff a3 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 1e 46 46 46 ff ff 99 ff ff ff ff ff ff ff ff 
03: ff 00 ff ff 00 4b ff ff 02 01 00 00 00 00 00 00 
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 03 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
02: ff ff ff 90 3e 90 3e ed af ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 00 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 00 13 ff ff 00 00 00 ff 00 20 3e b0 09 ff ff ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff ff 00 00 00 00 ff ff ff ff ff ff ff 00 00 ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: d4 d1 00 ff e3 ba e1 a9 ff ff ff ff ff ff ff ff 
06: 00 00 00 00 00 00 07 00 01 ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff 01 02 03 0c 01 01 ff 00 00 00 22 20 20 06 ff 
03: 32 04 28 1e ff 1f ff 1f ff 1f 54 0c 2a 06 00 00 
04: 00 00 00 00 02 02 02 ff ff ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 03 49 04 06 00 a4 00 a4 00 a4 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 7:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 95 02 10 00 00 00 00 00 63 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 ef de f8 80 f8 80 f8 80 01 
02: 22 01 06 00 00 00 ef ef 00 ef 00 00 00 00 00 00 
03: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 07 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=after-suspend

superiotool r4.0-2834-gdef50b0
Found Nuvoton NCT6776F (C) (id=0xc333) at 0x2e
Register dump:
idx 10 11 13 14 16 17 18 19  1a 1b 1c 1d 1e 1f 20 21  22 23 24 25 26 27 28 2a  2b 2c 2d 2e 2f
val ff ff ff ff ff ff ff ff  c0 68 03 00 ff ff c3 33  ff 00 20 00 00 00 00 68  08 80 00 00 03
def ff ff 00 00 ff ff ff ff  f0 78 00 00 ff ff c3 33  ff 00 64 00 MM 00 00 c0  00 81 00 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 0e 00 ff  00 00
def 01 03 f0 06 02 0e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0 f2
val 01 03 f8 04 00 00
def 01 03 f8 04 00 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1 f2
val 00 02 f8 03 00 00 00
def 01 02 f8 03 00 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 82
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70 f0 f1 f2 f3
val 00 03 e0 0b 08 09 32 00
def 00 00 00 00 08 09 32 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 00 ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff
def 03 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1, GPIOA)
idx 30 60 61 e0 e1 e2 e3 e4  f0 f1 f2 f3 f4 f5 f6 f7
val 00 00 00 ff ff ff ff ff  73 5b 00 7b 00 ff 00 ff
def 02 00 00 ff 00 00 00 ef  ff 00 00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val 0e ef 10 00 10 f7 00 00  00 ff 00 00 ff ff ff ff  ff ff ff ff ff 00
def 04 df 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee f0 f2 f3 f4 f6 f7  fe
val 01 00 00 04 00 06 1c 01  00 00 00 5c 00 00 00 c0  00
def 01 00 00 00 00 02 1c 00  00 00 00 00 00 00 00 c0  00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 e0 e1  e2 f0 f1 f2 f5 f6 f7 f8  f9 fa
val 01 02 90 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
def 00 00 00 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
LDN 0x0d (VID)
idx e0 e1 e2 e3 e4 e5 e6 e9  ee ef f0 f4 f5
val 00 00 00 00 00 00 00 00  88 00 00 00 00
def 00 00 00 00 00 00 00 00  88 00 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 00 00 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f1 f2
val 7f df ff fe f6 ff ff d3  ff 9f 9d 00 00
def ff df ff fe f6 ff ff d3  ff 9f 00 00 00
LDN 0x14 (SVID)
idx e0 e1 e3 e4
val 00 80 00 00
def 00 80 00 00
LDN 0x16 (Deep Sleep)
idx 30 e0 e1 e2
val 20 20 04 05
def 20 20 04 05
LDN 0x17 (GPIOA)
idx e0 e1 e2 e3 e4 e5
val ff ff ff ff 01 ff
def 01 00 00 00 01 00
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 a5 04 5d 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 a5 00 a5 ff a5 ff ff 50 00 00 00 00 84 00 00 
02: 61 80 d6 d6 80 ff 1d 20 ff ff ff da 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 50 4b ff ff ff ff ff 
04: 01 fe 2f df ff 00 3f ff 2d ff ff ff 18 05 00 a3 
05: ff ff ff ff ff ff ff ff c1 ff ff ff ff 01 00 ff 
06: 00 ff ff ff ff 01 00 ff ff ff ff ff ff ff ff ff 
07: 00 0a 00 23 80 23 80 23 80 ff ff ff ff ff ff ff 
08: ff 03 1f 0f ff 3c 3c 3c 00 00 00 00 00 00 00 00 
09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4 
0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 01 01 
0b: 00 00 00 00 00 00 33 00 1c 00 00 34 28 00 c4 ff 
0c: 01 00 00 00 00 00 00 00 00 1e 06 ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0c 00 40 01 01 01 01 3c ff a5 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 1e 46 46 46 ff ff 99 ff ff ff ff ff ff ff ff 
03: ff 00 ff ff 00 4b ff ff 02 01 00 00 00 00 00 00 
04: ff ff ff ff ff 59 03 ff ff ff ff ff ff ff 01 ff 
05: 5c 80 02 4c 00 51 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0c 32 40 01 01 01 01 3c ff 5d ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 14 41 46 46 ff ff 33 b2 ff ff ff ff ff ff ff 
03: ff 01 ff ff 01 ff ff ff 02 01 00 00 00 00 00 00 
04: ff ff ff ff ff f7 03 ff ff ff ff ff ff ff 02 ff 
05: 59 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 0c 00 40 01 01 01 01 3c ff a5 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 1e 46 46 46 ff ff 99 ff ff ff ff ff ff ff ff 
03: ff 00 ff ff 00 4b ff ff 02 01 00 00 00 00 00 00 
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 03 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
02: ff ff ff 90 3e 90 3e ed af ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 00 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 33 13 ff ff 00 00 00 ff 00 2e 3f b0 09 ff ff ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff ff 00 00 00 00 ff ff ff ff ff ff ff 00 00 ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: d4 d1 c0 ff e3 ba e1 a9 ff ff ff ff ff ff ff ff 
06: 00 00 00 00 00 00 07 01 01 ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff 01 02 03 01 01 01 ff 00 00 00 20 20 20 07 ff 
03: 31 07 29 12 ff 1f ff 1f ff 1f 54 0c 2a 06 00 00 
04: 00 00 00 00 02 02 02 ff ff ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 03 59 03 f7 00 a4 00 a4 00 a4 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 7:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 95 02 10 00 00 00 00 00 63 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 f0 20 f8 80 f8 80 f8 80 01 
02: 23 02 06 00 00 00 ef 70 00 ef 00 00 00 00 00 00 
03: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 07 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--SUOF0GtieIMvvwua--
