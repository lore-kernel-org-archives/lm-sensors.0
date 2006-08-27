From: prakash@punnoor.de (Prakash Punnoor)
Date: Sun, 27 Aug 2006 06:50:04 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <200608270850.07993.prakash@punnoor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi!

Arg, I actually wanted to continue writing my last email later, but pressed=
=20
the send button by accident...

Am Freitag 25 August 2006 20:23 schrieb Jean Delvare:

> Well, the question is, do the voltage values reported by "sensors"
> increase again if you stop underpowering your system? If they do,
> obviously that's your business and I couldn't care less ;)

No they dont. eg:
VCore:     +1.23 V  (min =3D  +0.00 V, max =3D  +4.08 V)

Bios shows 1.35V, so clearly the voltages are off.

Here are the dumps:
cat before.dump
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 03 ff 07 00 00 00 00 00 80 7f 09 07 b7 ff 61
10: d0 d0 ff 73 d4 80 81 82 03 ff 03 00 00 ff ff ff
20: 3f c3 00 b4 b3 00 00 af b4 19 1f 19 4b 02 02 02
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff 00 0d 2d ff ff ff ff ff ff ff
50: ff 31 7f 7f 7f 50 f5 00 90 00 02 12 00 00 00 00
60: 00 19 7f 21 90 03 ff ff 14 19 48 21 90 03 ff ff
70: 7f 7f 7f 00 00 03 ff ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 ff ff ff ff 00 00 ff c0 02 00 99 99
90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

cat after.dump
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 03 64 00 00 00 00 00 00 80 7f 09 07 a9 ff 61
10: d0 d0 ff 73 d4 80 81 82 03 ff 03 00 00 ff ff ff
20: 40 c3 00 b4 b3 00 00 af b4 1a 21 19 88 02 02 02
30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
40: 7f ff 7f ff 7f ff 00 0d 2d ff ff ff ff ff ff ff
50: ff 31 7f 7f 7f 50 f5 00 90 00 02 12 00 00 00 00
60: 00 19 7f 21 90 03 ff ff 14 19 48 21 90 03 ff ff
70: 7f 7f 7f 00 00 03 ff ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 ff ff ff ff 00 00 ff c0 02 00 99 99
90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


> I generated a new version of my it87 patch, which should report fan
> speeds properly:

Yes, looks better now. Maybe you want to lower the fan limits, as well?

fan1:      830 RPM  (min =3D 3245 RPM)                   ALARM
fan2:        0 RPM  (min =3D 3245 RPM)                   ALARM
fan3:      782 RPM  (min =3D    0 RPM)


> Do you know where I can get technical documentation for your
> processor? My reference document for K8 CPUs was AMD document 30430 so
> far, but I can't find your CPU revision there.

Actually I never searched for AMD docs, but in the AM2 section doc 33425=20
refers to 31117 and 31119.

> Depends on the size of the fan. A 120 mm fan at 2200 RPM should be
> almost silent. A 60 mm fan at 2200 RPM can already make some noise,
> although it should be acceptable.

It is this one: http://www.arctic-cooling.com/cpu2.php?idx=80&data=3D2&disc=
=3D, so=20
the fan should be quite big, that's what makes me wonder.

> I'm not sure about the "correctly" but yet the BIOS is most certainly
> trimming the values it considers too high to be relistic. But I am
> reluctant to do this in our drivers. It's up to the hardware to improve
> to make it possible to control fans and still monitor them. I think
> that's where we are going with 4-wire fans

True, but I probably can'T fix the broken hw anymore. ;-)

Cheers,
--=20
(?=3D                 =3D?)
//\ Prakash Punnoor /\\
V_/                 \_V
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060827=
/01f1dd2f/attachment.bin=20
