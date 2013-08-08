From: Sebastian Sjoholm <sebastian.sjoholm@gmail.com>
Date: Thu, 08 Aug 2013 04:41:24 +0000
Subject: Re: [lm-sensors] Unsuported ITE chipset 0x8771
Message-Id: <CAGnwK7pyGzZL4q8QAXKiQfWcN0ax0yd9=6xh1XX5wFWv+bMmKA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1134482396597277536=="
List-Id: <lm-sensors.vger.kernel.org>
References: <6CFD278BAABA444AAA6A1BAC172498CD@adminDator>
In-Reply-To: <6CFD278BAABA444AAA6A1BAC172498CD@adminDator>
To: lm-sensors@vger.kernel.org

--===============1134482396597277536==
Content-Type: multipart/alternative; boundary=001a1133123a42ba1704e368453a

--001a1133123a42ba1704e368453a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I was reading the old post regarding the unsupported ITE chipset, and did a
printout from my boards as well, I don't know if it helps.

# isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4
WARNING! Running this program can cause system crashes, data loss and worse=
!
I will probe address register 0x2e and data register 0x2f.
Probing bank 4 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 87 71 00 00 00 00 ff 0e 22 82 00 40 03 00 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 02 90 02 30 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 02 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 40 00 00 20 00 f0 00 01 00 00 00 00 00 00 00
# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse=
!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 19 02 ff 01 37 ff 07 37 ff 07 49 0f 00 82 ff 00
10: ff d2 5f 3b c7 80 00 00 00 ff 00 ff 9f 6f 6f 6f
20: 2f ba f2 8a ba f4 ba 8d 88 35 2e f8 80 f0 00 00
30: 7f fe af ef 0e 9f b9 ff 0d df 7b 2f 7e 78 ae 9f
40: df eb 6f b5 fd fc 5f 40 ad 6a d4 00 ff ff ff ff
50: ff 38 7f 7f 7f 40 00 00 90 00 01 12 60 00 00 00
60: 00 14 46 6a 14 41 0f ff 00 7f 7f ff 00 00 0f ff
70: 7f 7f 7f 80 00 00 0f ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 3c 02 04
90: ff 00 00 00 ff 00 00 00 40 00 00 00 00 b6 02 20
a0: fb f7 f7 f7 f7 f7 f7 ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
# modprobe it87 force_id=3D0x8721
# sensors
radeon-pci-0008
Adapter: PCI adapter
temp1:        +62.0=C3=82=C2=B0C

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +62.5=C3=82=C2=B0C  (high =3D +70.0=C3=82=C2=B0C)
                       (crit =3D +100.0=C3=82=C2=B0C, hyst =3D +97.0=C3=82=
=C2=B0C)

it8721-isa-0290
Adapter: ISA adapter
in0:          +0.56 V  (min =3D  +3.05 V, max =3D  +1.52 V)  ALARM
in1:          +2.23 V  (min =3D  +2.87 V, max =3D  +2.10 V)  ALARM
in2:          +2.90 V  (min =3D  +1.91 V, max =3D  +0.17 V)  ALARM
+3.3V:        +3.31 V  (min =3D  +0.00 V, max =3D  +4.44 V)  ALARM
in4:          +2.23 V  (min =3D  +2.68 V, max =3D  +0.16 V)  ALARM
in5:          +2.92 V  (min =3D  +0.56 V, max =3D  +1.48 V)  ALARM
in6:          +2.23 V  (min =3D  +1.44 V, max =3D  +1.51 V)  ALARM
3VSB:         +3.38 V  (min =3D  +3.82 V, max =3D  +4.18 V)  ALARM
Vbat:         +3.26 V
fan1:        5192 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D   16 RPM)  ALARM
temp1:        +53.0=C3=82=C2=B0C  (low  =3D -21.0=C3=82=C2=B0C, high =3D -3=
3.0=C3=82=C2=B0C)  ALARM  sensor =3D
thermistor
temp2:        +46.0=C3=82=C2=B0C  (low  =3D -75.0=C3=82=C2=B0C, high =3D +1=
11.0=C3=82=C2=B0C)  sensor =3D
thermistor
temp3:         -8.0=C3=82=C2=B0C  (low  =3D  -4.0=C3=82=C2=B0C, high =3D  -=
3.0=C3=82=C2=B0C)  sensor =3D
thermistor
intrusion0:  OK

I have total 5 of these boards, if requested I can printout from all of
them.

Regards,
Sebastian

--001a1133123a42ba1704e368453a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I was reading the old post regardin=
g the unsupported ITE chipset, and did a printout from my boards as well, I=
 don&#39;t know if it helps.</div><div><br></div><div><div># isadump -k 0x8=
7,0x01,0x55,0x55 0x2e 0x2f 4</div>
<div>WARNING! Running this program can cause system crashes, data loss and =
worse!</div><div>I will probe address register 0x2e and data register 0x2f.=
</div><div>Probing bank 4 using bank register 0x07.</div><div>Continue? [Y/=
n] y</div>
<div>=C2=A0 =C2=A0 =C2=A00 =C2=A01 =C2=A02 =C2=A03 =C2=A04 =C2=A05 =C2=A06 =
=C2=A07 =C2=A08 =C2=A09 =C2=A0a =C2=A0b =C2=A0c =C2=A0d =C2=A0e =C2=A0f</di=
v><div>00: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00=C2=A0</div><div>=
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>20: 87 =
71 00 00 00 00 ff 0e 22 82 00 40 03 00 00 00=C2=A0</div>
<div>30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>40=
: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>50: 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>60: 02 90 02 30 =
00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div>
<div>70: 00 02 00 00 04 04 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>80=
: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>90: 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>a0: 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div>
<div>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>c0=
: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>d0: 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div><div>e0: 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00=C2=A0</div>
<div>f0: 00 40 00 00 20 00 f0 00 01 00 00 00 00 00 00 00=C2=A0</div><div># =
isadump 0x295 0x296</div><div>WARNING! Running this program can cause syste=
m crashes, data loss and worse!</div><div>I will probe address register 0x2=
95 and data register 0x296.</div>
<div>Continue? [Y/n] y</div><div>=C2=A0 =C2=A0 =C2=A00 =C2=A01 =C2=A02 =C2=
=A03 =C2=A04 =C2=A05 =C2=A06 =C2=A07 =C2=A08 =C2=A09 =C2=A0a =C2=A0b =C2=A0=
c =C2=A0d =C2=A0e =C2=A0f</div><div>00: 19 02 ff 01 37 ff 07 37 ff 07 49 0f=
 00 82 ff 00=C2=A0</div><div>10: ff d2 5f 3b c7 80 00 00 00 ff 00 ff 9f 6f =
6f 6f=C2=A0</div><div>
20: 2f ba f2 8a ba f4 ba 8d 88 35 2e f8 80 f0 00 00=C2=A0</div><div>30: 7f =
fe af ef 0e 9f b9 ff 0d df 7b 2f 7e 78 ae 9f=C2=A0</div><div>40: df eb 6f b=
5 fd fc 5f 40 ad 6a d4 00 ff ff ff ff=C2=A0</div><div>50: ff 38 7f 7f 7f 40=
 00 00 90 00 01 12 60 00 00 00=C2=A0</div>
<div>60: 00 14 46 6a 14 41 0f ff 00 7f 7f ff 00 00 0f ff=C2=A0</div><div>70=
: 7f 7f 7f 80 00 00 0f ff ff ff ff ff ff ff ff ff=C2=A0</div><div>80: 00 00=
 00 00 00 00 00 00 00 00 00 00 00 3c 02 04=C2=A0</div><div>90: ff 00 00 00 =
ff 00 00 00 40 00 00 00 00 b6 02 20=C2=A0</div>
<div>a0: fb f7 f7 f7 f7 f7 f7 ff ff ff ff ff ff ff ff ff=C2=A0</div><div>b0=
: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=C2=A0</div><div>c0: ff ff=
 ff ff ff ff ff ff ff ff ff ff ff ff ff ff=C2=A0</div><div>d0: ff ff ff ff =
ff ff ff ff ff ff ff ff ff ff ff ff=C2=A0</div>
<div>e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=C2=A0</div><div>f0=
: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=C2=A0</div><div># modprob=
e it87 force_id=3D0x8721</div><div># sensors</div><div>radeon-pci-0008</div=
><div>Adapter: PCI adapter</div>
<div>temp1: =C2=A0 =C2=A0 =C2=A0 =C2=A0+62.0=C3=82=C2=B0C =C2=A0</div><div>=
<br></div><div>k10temp-pci-00c3</div><div>Adapter: PCI adapter</div><div>te=
mp1: =C2=A0 =C2=A0 =C2=A0 =C2=A0+62.5=C3=82=C2=B0C =C2=A0(high =3D +70.0=C3=
=82=C2=B0C)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(crit =3D +100.0=C3=82=C2=B0C, hyst =3D +97.=
0=C3=82=C2=B0C)</div>
<div><br></div><div>it8721-isa-0290</div><div>Adapter: ISA adapter</div><di=
v>in0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+0.56 V =C2=A0(min =3D =C2=A0+3.05=
 V, max =3D =C2=A0+1.52 V) =C2=A0ALARM</div><div>in1: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0+2.23 V =C2=A0(min =3D =C2=A0+2.87 V, max =3D =C2=A0+2.10 V) =
=C2=A0ALARM</div><div>
in2: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+2.90 V =C2=A0(min =3D =C2=A0+1.91 V=
, max =3D =C2=A0+0.17 V) =C2=A0ALARM</div><div>+3.3V: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+3.31 V =C2=A0(min =3D =C2=A0+0.00 V, max =3D =C2=A0+4.44 V) =C2=A0AL=
ARM</div><div>in4: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+2.23 V =C2=A0(min =3D=
 =C2=A0+2.68 V, max =3D =C2=A0+0.16 V) =C2=A0ALARM</div><div>in5: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0+2.92 V =C2=A0(min =3D =C2=A0+0.56 V, max =3D =
=C2=A0+1.48 V) =C2=A0ALARM</div>
<div>in6: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+2.23 V =C2=A0(min =3D =C2=A0+1=
.44 V, max =3D =C2=A0+1.51 V) =C2=A0ALARM</div><div>3VSB: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 +3.38 V =C2=A0(min =3D =C2=A0+3.82 V, max =3D =C2=A0+4.18 V) =C2=
=A0ALARM</div><div>Vbat: =C2=A0 =C2=A0 =C2=A0 =C2=A0 +3.26 V =C2=A0</div><d=
iv>fan1: =C2=A0 =C2=A0 =C2=A0 =C2=A05192 RPM =C2=A0(min =3D =C2=A0 =C2=A00 =
RPM)</div>
<div>fan2: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 RPM =C2=A0(min =3D =C2=A0 1=
6 RPM) =C2=A0ALARM</div><div>temp1: =C2=A0 =C2=A0 =C2=A0 =C2=A0+53.0=C3=82=
=C2=B0C =C2=A0(low =C2=A0=3D -21.0=C3=82=C2=B0C, high =3D -33.0=C3=82=C2=B0=
C) =C2=A0ALARM =C2=A0sensor =3D thermistor</div><div>temp2: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0+46.0=C3=82=C2=B0C =C2=A0(low =C2=A0=3D -75.0=C3=82=C2=B0C, hi=
gh =3D +111.0=C3=82=C2=B0C) =C2=A0sensor =3D thermistor</div>
<div>temp3: =C2=A0 =C2=A0 =C2=A0 =C2=A0 -8.0=C3=82=C2=B0C =C2=A0(low =C2=A0=
=3D =C2=A0-4.0=C3=82=C2=B0C, high =3D =C2=A0-3.0=C3=82=C2=B0C) =C2=A0sensor=
 =3D thermistor</div><div>intrusion0: =C2=A0OK</div></div><div><br></div><d=
iv>I have total 5 of these boards, if requested I can printout from all of =
them.</div>
<div><br></div><div>Regards,</div><div>Sebastian</div></div>

--001a1133123a42ba1704e368453a--


--===============1134482396597277536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1134482396597277536==--
