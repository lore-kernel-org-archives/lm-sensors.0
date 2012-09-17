From: MrNice <wxcvbn2006@iol.ie>
Date: Mon, 17 Sep 2012 10:37:25 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <5056FD65.3000907@iol.ie>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


On Sun, Sep 16, 2012 at 09:03:17PM +0100, Jean-Pierre Thibert wrote:
> On 16/09/12 19:53, Guenter Roeck wrote:
> >On Sun, Sep 16, 2012 at 07:44:58AM +0100, Jean-Pierre Thibert wrote:
> >[ ... ]
> >>>
> >>I have an ASRock 970 Extreme4 UEFI version P2.00
> >>In the H/W Monitor page of the UEFI/BIOS, I have the following:
> >>CPU Temperature :    36.5 =B0C
> >>M/B Temperature :    28.0 =B0C
> >>
> >>CPU Fan 1 Speed :    1065 RPM (this is a pwm connector with 4 pins.
> >>I have a pwm fan) called CPU_FAN1 on the motherboard
> >>CPU Fan 2 Speed :    N/A (this is a 3 pins connector. No connected
> >>fan) called CPU_FAN2 on the motherboard
> >>Chassis Fan 1 Speed :    N/A (this is a pwm connector with 4 pins.
> >>No connected fan) called CHA_FAN1 on the motherboard
> >>Chassis Fan 2 Speed :    730 RPM (this is a 3 pins connector. I have
> >>a 3 pins connected fan) called CHA_FAN2 on the motherboard
> >>Chassis Fan 3 Speed :    760 RPM (this is a 3 pins connector. I have
> >>a 3 pins connected fan) called CHA_FAN3 on the motherboard
> >>Power Fan Speed :    N/A (this is a 3 pins connector. No connected
> >>fan) called PWR_FAN1 on the motherboard
> >>
> >>Vcore :    +1.328 V
> >>+ 12.00V :    +12.144 V
> >>+ 5.00V :    +5.136 V
> >>+ 3.30V :    +3.280 V
> >>
> >>lm-sensors has almost all the values but no fan speed.
> >>I don't know why I had the CPU_FAN2 for a short time and it disappeared.
> >>I can't understand what you suggest to have the value back. Could
> >I did not suggest anything.
> >
> >I found some information about the board. The chassis fans are connected=
 to
> >memory mapped IO, so there is nothing we can do there. There are two CPU=
 fans,
> >multiplexed to the SuperIO chip through GPIO pins. It _might be possible=
 that
> >we can manually set those pins.
> >
> >Please send the output of the following commands:
> >	isadump -y -k 0x87,0x87 0x2e 0x2f
> >	isadump -y -k 0x87,0x87 0x2e 0x2f 8
> >	dmidecode
> >
> >Thanks,
> >Guenter
> >
> >
> >
> >
> sudo isadump -y -k 0x87,0x87 0x2e 0x2f
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff 00 ff ff ff ff 0b ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff f8 ce 00 00 ff ff
> 20: c3 33 ff 00 5c 00 00 90 00 ff 60 04 81 00 00 01
> 30: e1 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 02 90 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
> 70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: 7f 7f ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: 00 00 00 a4 ff 10 00 87 47 00 00 ff ff ff ff ff
>
>
> sudo isadump -y -k 0x87,0x87 0x2e 0x2f 8
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff 00 ff ff ff ff 08 ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff f8 ce 00 00 ff ff
> 20: c3 33 ff 00 5c 00 00 90 00 ff 60 04 81 00 00 01
> 30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: f3 f3 00 ff 00 00 00 00 ff ff ff ff ff ff ff ff
>

Not good :(. The problem is "30: 01" above; it suggests that the SuperIO GP=
IO pins
which I thought would be used to control the fan multiplexer are in fact di=
sabled.

One more try ... please download superiotool fromhttp://roeck-us.net/linux/=
bin/superiotool
and run it with "sudo ./superiotool -d -e".

If you don't want to run untrusted binaries, please clone the latest version
of coreboot (git clonehttp://review.coreboot.org/p/coreboot) and build and =
run
superiotool from it (cd util/superiotool; make; sudo ./superiotool -d -e).

Thanks,
Guenter

sudo ./superiotool -d -e
superiotool r4.0-2514-gf419483
Found Nuvoton NCT6776F (C) (id=3D0xc333) at 0x2e
Register dump:
idx 10 11 13 14 16 17 18 19  1a 1b 1c 1d 1e 1f 20 21  22 23 24 25 26 27 28 =
2a  2b 2c 2d 2e 2f
val ff ff ff ff ff ff ff ff  f8 ce 00 00 ff ff c3 33  ff 00 5c 00 00 90 00 =
60  04 81 00 00 01
def ff ff 00 00 ff ff ff ff  f0 78 00 00 ff ff c3 33  ff 00 64 00 MM 00 00 =
c0  00 81 00 00 MM
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
val 00 03 f8 04 00 00
def 01 03 f8 04 00 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1 f2
val 00 02 f8 03 00 00 00
def 01 02 f8 03 00 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 83
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70 f0 f1 f2 f3
val 00 00 00 00 08 09 32 00
def 00 00 00 00 08 09 32 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 00 ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff
def 03 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1, GPIOA)
idx 30 60 61 e0 e1 e2 e3 e4  f0 f1 f2 f3 f4 f5 f6 f7
val 01 00 00 ff ff ff ff ff  f3 f3 00 f3 00 00 00 00
def 02 00 00 ff 00 00 00 ef  ff 00 00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val 36 ff 00 00 00 ff ff ff  ff 4c 00 ff 00 00 ff 0c  00 ff 00 00 00 00
def 04 df 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee f0 f2 f3 f4 f6 f7  fe
val 01 00 00 05 00 02 4c 00  00 00 00 5c 00 00 00 c0  00
def 01 00 00 00 00 02 1c 00  00 00 00 00 00 00 00 c0  00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 e0 e1  e2 f0 f1 f2 f5 f6 f7 f8  f9 fa
val e1 02 90 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
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
val ff df ff fe f6 ff ff d3  ff 9f 00 00 00
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
00: 04 ff 04 c0 00 ff ff ff ff ff ff ff ff ff ff ff
01: 04 ff 00 00 00 00 ff ff 40 00 00 00 00 00 00 00
02: 72 e7 cf ce 03 d6 03 1c ff ff ff da 00 00 00 e3
03: ba e3 ba 00 00 00 00 00 00 00 00 ff ff ff ff ff
04: 03 de 30 ff ff 00 3f ff 2d ff ff ff 08 05 00 a3
05: ff ff ff ff ff ff ff ff c1 ff ff ff ff 01 00 ff
06: cf ff ff ff ff 01 00 ff ff ff ff ff ff ff ff ff
07: 00 0a 00 1c 80 1a 00 7f 80 ff ff ff ff ff ff ff
08: ff 03 1f 0f ff 3c 3c 3c 00 00 00 00 00 00 00 00
09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4
0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 00 01
0b: 00 00 00 00 00 00 27 00 1c 00 00 34 28 c0 c4 ff
0c: 01 00 00 00 00 00 00 00 00 08 01 ff ff ff ff ff
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Bank 1:
     00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
00: 01 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 01 ff
05: 1a 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff
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
00: 82 2d 12 0a 0a c0 ff 60 ff c0 ff ff 00 ff ff ff
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
02: 00 28 32 3c 46 ff ff 8c aa c8 e6 ff ff ff ff ff
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 02 ff
05: 7f 80 00 72 00 72 00 ff ff ff ff ff ff ff ff ff
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
00: 03 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff
03: ff 00 ff ff 00 3c ff ff 00 01 00 00 00 00 00 00
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
02: ff ff ff 96 64 96 64 e1 96 ff ff ff ff ff ff ff
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
04: 3f 00 03 ff ff ff ff ff ff ff ff ff ff ff 04 ff
05: 33 13 ff ff 00 00 00 ff 00 d2 3b b2 09 ff ff ff
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
05: d8 d1 80 ff e3 ba ce a9 ff ff ff ff ff ff ff ff
06: 00 00 00 00 00 00 07 00 00 ff ff ff ff ff ff ff
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
02: ff 01 02 03 01 01 01 ff 00 00 00 1c 1c 1c 07 ff
03: ff 1f ff 1f ff 1f ff 1f ff 1f 00 00 00 00 00 00
04: ff 1f 00 00 02 02 02 ff ff ff ff ff ff ff 06 ff
05: 7f 7f 7f 7f 7f 7f 00 a4 00 a4 00 a4 00 a4 00 a4
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
00: ff 10 02 00 00 00 00 00 00 00 00 00 00 00 00 00
01: 00 00 00 00 00 00 00 f8 80 f8 80 f8 80 f8 80 00
02: 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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








_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
