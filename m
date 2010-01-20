From: Roderick Johnstone <rmj@ast.cam.ac.uk>
Date: Wed, 20 Jan 2010 11:01:33 +0000
Subject: [lm-sensors] ADT 7490 report
Message-Id: <4B56E28D.6080704@ast.cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi

I have an Intel DP55WB motherboard which sensors-detect reports has an=20
adt 7490 chip.

Probing for `Analog Devices ADT7490'...                     Success!
     (confidence 5, driver `to-be-written')

I downloaded the standalone driver from:
http://khali.linux-fr.org/devel/misc/adt7490/
as linked from:
http://www.lm-sensors.org/wiki/Devices

After building and modprobing, sensors reports:

linux> sensors
adt7490-i2c-0-2c
Adapter: SMBus I801 adapter at 1000
in0:         +1.50 V  (min =3D  +0.00 V, max =3D  +3.31 V)
in1:         +0.87 V  (min =3D  +0.00 V, max =3D  +2.99 V)
in2:         +3.29 V  (min =3D  +0.00 V, max =3D  +4.39 V)
in3:         +5.16 V  (min =3D  +0.00 V, max =3D  +6.68 V)
in4:        +12.01 V  (min =3D  +0.00 V, max =3D +15.69 V)
in5:         +2.17 V  (min =3D  +0.00 V, max =3D  +4.48 V)
fan1:        728 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:       1124 RPM  (min =3D    0 RPM)
fan4:          0 RPM  (min =3D    0 RPM)
temp1:         FAULT  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  ALARM
                       (crit =3D +100.0=B0C, hyst =3D +100.0=B0C)
temp2:       +35.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)
temp3:       +37.8=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)

The fan speeds look plausible, compared with what I have seen reported=20
in the bios.

But, I was expecting to see temperatures for each of the 4 cores in the=20
i7-860 cpu.

I'd be happy to work with the developer in testing any updates that=20
might fix this.

Thanks for the initial support of this chip.

Roderick Johnstone


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
