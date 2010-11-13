From: Owl <owl@umail.ru>
Date: Sat, 13 Nov 2010 08:09:20 +0000
Subject: [lm-sensors] Fintek F71869
Message-Id: <4CDE47B0.5040909@umail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi.

Now I have Jetway NC9C-550-LF motherboard.
Link: http://www.jetwaycomputer.com/NC9C.html

MB have Intel Atom N550 processor and Fintek F71869 Super-IO chip.

1) According to http://www.lm-sensors.org/wiki/Devices - you "Waiting=20
for someone with such hardware. Datasheet available.", maybe I can help=20
with this?

gentoo ~ # uname -a
Linux gentoo 2.6.35-gentoo-r12 #1 SMP Tue Nov 2 13:43:58 MSK 2010 i686=20
Intel(R) Atom(TM) CPU N550 @ 1.50GHz GenuineIntel GNU/Linux

gentoo ~ # sensors-detect
Found `Fintek F71869FG Super IO Sensors'                    Success!
     (address 0x290, driver `to-be-written')

On MB chip marked as F71869ED.

2) coretemp on this MB show me wrong values:

coretemp coretemp.0: Unable to read TjMax from CPU.
coretemp coretemp.0: Using relative temperature scale!
coretemp coretemp.1: Unable to read TjMax from CPU.
coretemp coretemp.1: Using relative temperature scale!

gentoo ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +14.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +19.0=B0C  (crit =3D +100.0=B0C)

My sensors3.conf now empty.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
