From: Owl <owl@umail.ru>
Date: Sun, 28 Nov 2010 21:59:01 +0000
Subject: [lm-sensors] Intel Atom N550 coretemp
Message-Id: <4CF2D0A5.4000502@umail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi. My Atom N550 still show me wrong temperatures:

gentoo ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +15.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +20.0=B0C  (crit =3D +100.0=B0C)

Real temperature according to BIOS - about 40-45.

gentoo ~ # uname -a
Linux gentoo 2.6.36-gentoo-r3 #1 SMP Sat Nov 27 21:07:58 MSK 2010 i686=20
Intel(R) Atom(TM) CPU N550 @ 1.50GHz GenuineIntel GNU/Linux

gentoo ~ # dmesg | grep coretemp
coretemp coretemp.0: Unable to read TjMax from CPU.
coretemp coretemp.0: Using relative temperature scale!
coretemp coretemp.1: Unable to read TjMax from CPU.
coretemp coretemp.1: Using relative temperature scale!


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
