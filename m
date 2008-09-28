From: =?unknown-8bit?q?=C3=93scar?= Fuentes <ofv@wanadoo.es>
Date: Sun, 28 Sep 2008 20:22:50 +0000
Subject: [lm-sensors] Does this makes any sense?
Message-Id: <4p40uijp.fsf@telefonica.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This is not a problem with lm-sensors, but an attempt to understand
what can cause the values it outputs.

When I start four mprime processes in "torture test" mode on a Q6600
system it shows a flat 100% CPU usage line and `sensors` report
temperatures around or below 70 degrees Celsius for each core, which
is consistent with Intel's specs for a fully loaded CPU:

oscar@qcore:~/Archivo/prime$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +73.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +71.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +62.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +58.0=B0C  (crit =3D +100.0=B0C)

However, when compiling an application with "make -j 4" the CPU usage
is around 95% (which is expected as there is quite a bit of I/O
involved) but the temperature goes up to 88 degrees on some cores!
This is a typical output of `sensors` on this scenario:

coretemp-isa-0000                  =20
Adapter: ISA adapter               =20
Core 0:      +85.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +82.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +71.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +65.0=B0C  (crit =3D +100.0=B0C)

What can cause this difference on temperatures, when mprime stresses
the CPU much more than the compiler?

--=20
Oscar

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
