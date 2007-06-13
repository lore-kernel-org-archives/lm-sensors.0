From: linux@horizon.com
Date: Wed, 13 Jun 2007 06:30:21 +0000
Subject: [lm-sensors] Trying to get a w83627hf working
Message-Id: <20070613063021.28033.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Greetings.  I just last weekend finally figured out the magic needed to
get i2c working (I could never figure out which algorithm to use; finally
it was revealed to me that I didn't need to pick from that column at all;
the drivers select them if they need them), and got sensors working on
a couple of machines.

Of course, one of the machines promptly proceeded to have a motherboard
failure Tuesday morning.  I guess it's been too long since I last
made offering to placate Loki.

Anyway, new motherboard, and new sensors chip.  Yes, the BIOS reports
reasonable values.   sensors-detect detects the W83627HF-AW chip I
can see on the motherboard (Abit AX8, if anyone cares).  But sensors(1)
reports garbage:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +30 C

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)             =20
VCore 2:   +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)             =20
+3.3V:     +4.08 V  (min =3D  +2.82 V, max =3D  +3.79 V)       ALARM =20
+5V:       +5.16 V  (min =3D  +6.42 V, max =3D  +6.85 V)       ALARM =20
+12V:     +11.86 V  (min =3D +15.50 V, max =3D +15.50 V)       ALARM =20
-12V:      +1.21 V  (min =3D  +0.63 V, max =3D  +5.98 V)             =20
-5V:       +2.29 V  (min =3D  +4.70 V, max =3D  +0.18 V)       ALARM =20
V5SB:      +5.56 V  (min =3D  +6.75 V, max =3D  +1.45 V)       ALARM =20
VBat:      +1.26 V  (min =3D  +3.06 V, max =3D  +3.82 V)       ALARM =20
fan1:        0 RPM  (min =3D    0 RPM, div =3D 2)                    =20
fan2:        0 RPM  (min =3D    0 RPM, div =3D 2)                    =20
fan3:        0 RPM  (min =3D    0 RPM, div =3D 2)                    =20
temp1:       -48 C  (high =3D    -1 C, hyst =3D  +124 C)   sensor =3D diode=
          =20
temp2:     -48.0 C  (high =3D   +80 C, hyst =3D   +75 C)   sensor =3D diode=
          =20
temp3:     -48.0 C  (high =3D   +80 C, hyst =3D   +75 C)   sensor =3D diode=
          =20
vid:      +0.000 V  (VRM Version 2.4)
alarms:  =20
beep_enable:
          Sound alarm disabled


But now I'm annoyed.  Get data sheet, read data sheet.
Write register-dumper.  H'm... Config reggister CR22
(accessed via the 0x23/0x2f port pair) is set to 0xbf.
That means that the hardware monitor is powered down!
Set bit CR22.6 to 1... still not working.

Try the "reset" module option.  No change.  (The sensors(1) output above
is after all this fiddling about.  The +12V and +5V numbers are somewhat
plausible, as the +5VSB might be.  I don't remember if they were worse
before I played with the power bit.  But I know it can monitor the fans,
and isn't.  The Vcore numbers, in particular, are obviosuly wrong.

Here are what the BIOS boot menu reports.  Voltages sparated by a slash
were flickering.  This is copied off paper, so I didn't write trailing
zeros.

	Value		Min	Max
Core	1.386/1.400	0.0	1.7
DDR	2.64		2.4	2.9
DDR Vtt	1.33		1.20	1.45
NB	1.60		1.40	1.70
SB	2.52		2.25	2.75
HyperT	1.22		0.95	1.45
ATX+5	5.13		4.00	6.00
ATX+3.3	3.34		2.65	3.95
+5SB	5.13		4.00	6.00
ATX+12	12.27		9.60	14.40

CPU fan	2100 RPM
NB fan	4860/4920 (actually a case fan)
SYS fan	4860/4920 (an identical case fan)
AUX fan (0 - not connected)

	Temp	Beep	Shutdown
CPU	43/44	65	85
System	28	50	65
PWM	31/32	70	90	(Is this the CPU power supply?)
(There were also some enable bits I forgot to copy.)
So those are the answers I *should* get.... what's going on?


Here's my register dumper output.  The long vertical range is the
config registers.  The high byte is the logical device number (0xff
for "global").  The leading =3D and - signs are just to help you keep
your place.

Then I dump out the hardware monitor registers via the ports at 0x295
and 0x296.  First, all registers in the 0x00..0x7f range, then the
0x50..0x5f range with the 8 possible bank selects.  (Yes, I unloaded
the module while doing this!)

Reg	Value	Binary
=FF02	ff  11111111
 ff07	ff  11111111
-ff20	52  01010010
 ff21	41  01000001
 ff22	ff  11111111 Hardware monitor powered on (was 10111111)
 ff23	fe  11111110
 ff24	c0  11000000
 ff25	00  00000000
 ff26	00  00000000
 ff27	ff  11111111
 ff28	00  00000000
 ff29	00  00000000
 ff2a	7c  01111100
 ff2b	c0  11000000
 ff2c	ff  11111111
 ff2d	30  00110000
 ff2e	00  00000000
 ff2f	ff  11111111
=0030	01  00000001
-0060	03  00000011
 0061	f0  11110000
-0070	06  00000110
 0074	02  00000010
-00f0	0e  00001110
 00f1	00  00000000
 00f2	ff  11111111
 00f4	00  00000000
 00f5	00  00000000
=0130	01  00000001
-0160	03  00000011
 0161	78  01111000
-0170	07  00000111
 0174	03  00000011
-01f0	3b  00111011
=0230	01  00000001
-0260	03  00000011
 0261	f8  11111000
-0270	04  00000100
-02f0	00  00000000
=0330	00  00000000
-0360	00  00000000
 0361	00  00000000
-0370	00  00000000
-03f0	00  00000000
 03f1	00  00000000
=0530	01  00000001
-0560	00  00000000
 0561	60  01100000
 0562	00  00000000
 0563	64  01100100
-0570	01  00000001
 0572	0c  00001100
-05f0	80  10000000
=0630	00  00000000
-0660	00  00000000
 0661	00  00000000
-0670	00  00000000
=0730	01  00000001
-0760	00  00000000
 0761	00  00000000
 0762	00  00000000
 0763	00  00000000
-0770	00  00000000
-07f0	ff  11111111
 07f1	00  00000000
 07f2	00  00000000
=0830	00  00000000
-08f0	ff  11111111
 08f1	ff  11111111
 08f2	ff  11111111
 08f3	00  00000000
 08f4	ff  11111111
 08f5	00  00000000
 08f6	00  00000000
 08f7	00  00000000
	30	00  00000000
-09f0	ff  11111111
 09f1	ff  11111111
 09f2	ff  11111111
 09f3	00  00000000

30	00  00000000 ACPI inactive
-0a70	00  00000000
-0ae0	00  00000000
 0ae1	00  00000000 Keyboard wake-up index
 0ae2	77  01110111 Keyboard wake-up data (great, more multiplexing!)
 0ae3	00  00000000
 0ae4	40  01000000 Power-on state =3D old state
 0ae5	00  00000000
 0ae6	00  00000000
 0ae7	00  00000000
-0af0	00  00000000
 0af1	af  10101111
 0af2	ff  11111111
 0af3	3e  00111110
 0af4	00  00000000
 0af6	00  00000000
 0af7	00  00000000
 0af9	00  00000000
=0B30	01  00000001 Hardware monitor active
-0b60	02  00000010=20
 0b61	90  10010000
-0b70	00  00000000 IRQ =3D 0 (none)
-0bf0	00  00000000 Disable power-on beep
hw_base is 0x0290
          0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
HW_00	 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
HW_10	 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
HW_20	 ff ff ff c0 c3 c6 c8 d0 ff ff ff ff 00 ff 00 ed
HW_30	 b0 ff ef ff ff fe bd 9d f7 ff 7c ff ff ff 00 00
HW_40	 01 00 00 00 00 00 00 5f 1f 03 89 44 00 95 07 a3
HW_50	 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
HW_60	 ff ff ff c0 c3 c6 c8 d0 ff ff ff ff 00 ff 00 ed
HW_70	 b0 ff ef ff ff fe bd 9d f7 ff 7c ff ff ff 00 00
Bank 0	 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Bank 1	 d0 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff
Bank 2	 d0 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff
Bank 3	 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Bank 4	 00 00 00 00 00 00 00 00 19 0c 05 03 11 00 ff ff
Bank 5	 d0 4f 00 00 36 fb ef bf 00 00 00 00 00 00 00 00
Bank 6	 d0 02 31 5f 32 2f 2e 2d d0 02 31 5f 32 2f 2e 2d
Bank 7	 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


As you can see, starting at 0x20 and 0x60, VcoreA, VcoreB, and +3.3Vin
readings are all 0xff =3D 4.08 V.  The VCoreA high limit at 0x2b
is clearly 0xff, so I don't see where the BIOS monitor gets 1.7V.

Is there anything obviosuly misconfigured here?


Thanks!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
