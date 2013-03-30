From: "dev.local" <dev.local@gmail.com>
Date: Sat, 30 Mar 2013 16:06:28 +0000
Subject: [lm-sensors] ITE8518 (Gigabyte U2442 Line)
Message-Id: <51570D84.8020204@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi everyone.

Recent Gigabyte U2442V "ultrabook" is equipped with ITE8518, which is=20
not listed under http://www.lm-sensors.org/wiki/Devices , so I suppose=20
it's not supported and will not be supported in the near future.

After quick googling I was unable to find datasheets or any other=20
information for ITE8518.

I am quite motivated to help with testing at least, because U2442V is=20
too hot under linux without proper fan controls.

Here's what 'sensors' usually show:

# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +50.1=B0C  (crit =3D +103.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +51.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
Core 0:         +47.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
Core 1:         +49.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)

If someone would give me a reference point (e.g., similar supported=20
chipset) I can also try to help with development.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
