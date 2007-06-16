From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 16 Jun 2007 15:20:04 +0000
Subject: Re: [lm-sensors] ASUS M2NPV-VM problems
Message-Id: <4673ffa48408c@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <465D7955.7060307@zerone.se>
In-Reply-To: <465D7955.7060307@zerone.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dnia 16-06-2007 o godz. 11:53 Jean Delvare napisa=B3(a):
> Hi Raivo,
>=20
> On Wed, 30 May 2007 15:17:09 +0200, Raivo Kask wrote:
> > My configuration looks like this:
> > MB:         ASUS M2NPV-VM
> > CPU:        AMD 64 X2 Dual Core Processor 4800+
> > OS:         Ubuntu 7.04 (Linux 2.6.20-16-generic #2 SMP)
>=20
> >     - should VID be =3D 0.000 V
>=20
> If you provide a dump of
> your chip, I will take a look:
>=20
> rmmod it87
> isadump 0x295 0x296
> isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
>

The Asus M2NPV-MX also returns VID =3D +0.000V.

The dump is following:
ubuntu@ubuntu:~$ isadump 0x295 0x296
Error: Can only be run as root (or make it suid root)
ubuntu@ubuntu:~$ sudo isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss
and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 00 64 00 00 00 00 00 00 80 7f 09 07 87 ff ff=20
10: ff ff ff 70 50 7f 7f 7f 00 ff ff ff ff ff ff ff=20
20: 4f c8 00 b2 b0 00 00 b0 b4 29 2c 19 05 01 01 01=20
30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00=20
40: 7f ff 7f ff 7f ff 00 0d 2d ff ff ff ff ff ff ff=20
50: ff 31 7f 7f 7f 50 f5 00 90 00 3e 12 60 00 00 00=20
60: 7f 7f 7f 00 00 03 ff ff 7f 7f 7f 00 00 03 ff ff=20
70: 7f 7f 7f 00 00 03 ff ff ff ff ff ff ff ff ff ff=20
80: 00 00 00 00 ff ff ff ff 00 00 ff ca 02 00 99 99=20
90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff=20
a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff=20
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20

ubuntu@ubuntu:~$ isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
Error: Can only be run as root (or make it suid root)
ubuntu@ubuntu:~$ sudo isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
WARNING! Running this program can cause system crashes, data loss
and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 7 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00=20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
20: 87 16 01 01 00 00 00 00 00 00 00 00 1f 00 00 00=20
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00=20
70: 00 00 00 38 00 04 00 00 00 00 00 00 00 00 00 00=20
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
b0: 00 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00=20
c0: 01 00 00 40 00 00 00 00 01 00 00 40 00 00 00 00=20
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
f0: 00 00 00 00 00 00 00 00 00 00 00 00 3f 00 00 00=20

I hope it is helpful.

Regards,
Krzysztof
=20

----------------------------------------------------
Wroc=B3aw Non Stop - eksplozja kultury we Wroc=B3awiu!=20
22 czerwca - 1 lipca 2007.=20
W ramach festiwalu wyst=B1pi=B1 m.in. Iggy Pop & The Stooges!
wwW.wroclawnonstop.pl http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.=
pl%2Fas%2Figgypop.html&sid=1192



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
