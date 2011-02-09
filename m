From: Owl <owl@umail.ru>
Date: Wed, 09 Feb 2011 09:48:51 +0000
Subject: [lm-sensors] coretemp output changed after loading acpi_cpufreq
Message-Id: <4D526303.6060506@umail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

gentoo ~ # uname -a
Linux gentoo 2.6.36-gentoo-r7 #1 SMP Fri Jan 14 14:34:23 MSK 2011 i686=20
Intel(R) Atom(TM) CPU N550 @ 1.50GHz GenuineIntel GNU/Linux

gentoo ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +18.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +22.0=B0C  (crit =3D +100.0=B0C)

gentoo ~ # modprobe acpi_cpufreq
gentoo ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +37.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +41.0=B0C  (crit =3D +100.0=B0C)

It's normal?
I think, second output is much closer to BIOS values.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
