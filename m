From: =?iso-8859-2?B?TOHvYQ==?= <durchanek@gmail.com>
Date: Thu, 26 Apr 2007 21:23:51 +0000
Subject: Re: [lm-sensors] Some W83627HG-AW chip
Message-Id: <015501c78849$2ff8e7a0$0201a8c0@reykjavik>
List-Id: <lm-sensors.vger.kernel.org>
References: <007001c78715$99c424e0$0201a8c0@reykjavik>
In-Reply-To: <007001c78715$99c424e0$0201a8c0@reykjavik>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
And thanks for reply... I have fixed this already with help from Winbond
guys (thanks again). You are right, correct driver was w83793, kernel
upgrade solved this and sensors are working nice now.

	L=E1=EFa

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Thursday, April 26, 2007 2:07 PM
> To: L=E1=EFa
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Some W83627HG-AW chip
>=20
> Hi L=E1=EFa,
>=20
> On Wed, 25 Apr 2007 10:42:04 +0200, L=E1=EFa wrote:
> > W83627HG-AW is another surprise from SuperMicro, there should be
> W8327EHG on
> > board (they are not so precise). Here is some output from sensors-
> detect:
> >
> > Driver `w83793' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus I801 adapter at 1100'
> >     Busdriver `i2c-i801', I2C address 0x2f
> >     Chip `Winbond W83793R/G' (confidence: 8)
> > .....
> > Driver `w83781d' (should be inserted):
> >   Detects correctly:
> >   * ISA bus address 0x0290 (Busdriver `i2c-isa')
> >     Chip `Winbond W83627HF' (confidence: 8)
> > Driver `w83627hf' (should be inserted):
> >   Detects correctly:
> >   * ISA bus address 0x0295 (Busdriver `i2c-isa')
> >     Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)
> >
> > both modules are compiled in kernel, but sensors doesn't show useful
> output:
>=20
> Which "both"? There are three kernel modules listed above, w83793,
> w83781d and w83627hf. The sensors-detect script is wrongly suggesting
> two drivers for the same device. This is fixed by now, I guess you are
> using a somewhat old version of the script.
>=20
> So the bottom line is that you should NOT use the w83781d driver.
>=20
> >
> > w83627hf-isa-0290
> > Adapter: ISA adapter
> > VCore 1:   +0.03 V  (min =3D  +1.09 V, max =3D  +1.50 V)       ALARM
> > VCore 2:   +0.05 V  (min =3D  +1.09 V, max =3D  +1.50 V)       ALARM
> > +3.3V:     +0.05 V  (min =3D  +2.82 V, max =3D  +3.79 V)       ALARM
> > +5V:       +5.08 V  (min =3D  +1.10 V, max =3D  +4.89 V)       ALARM
> > +12V:      +0.12 V  (min =3D +13.80 V, max =3D  +0.55 V)       ALARM
> > -12V:     -14.66 V  (min =3D  -1.01 V, max =3D  +1.37 V)       ALARM
> > -5V:       -7.56 V  (min =3D  -6.00 V, max =3D  -1.98 V)       ALARM
> > V5SB:      +5.59 V  (min =3D  +4.78 V, max =3D  +0.59 V)       ALARM
> > VBat:      +3.36 V  (min =3D  +3.78 V, max =3D  +2.19 V)       ALARM
> > fan1:        0 RPM  (min =3D    0 RPM, div =3D 2)
> > fan2:        0 RPM  (min =3D 8766 RPM, div =3D 2)              ALARM
> > fan3:        0 RPM  (min =3D 3054 RPM, div =3D 2)              ALARM
> > temp1:      +126 C  (high =3D   +26 C, hyst =3D   -86 C)   sensor > the=
rmistor
> > ALARM
> > temp2:    +126.5 C  (high =3D   +80 C, hyst =3D   +75 C)   sensor > the=
rmistor
> > ALARM
> > temp3:    +126.5 C  (high =3D   +80 C, hyst =3D   +75 C)   sensor > the=
rmistor
> > ALARM
> > vid:      +1.519 V  (VRM Version 11.0)
> > alarms:   Chassis intrusion detection                      ALARM
> > beep_enable:
> >           Sound alarm enabled
> >
> > I am using Gentoo Linux, gentoo-sources-2.6.19, architecture amd64. Btw.
> I
> > was a bit surprised that amd64 kernel is missing CONFIG_ISA option, but
> > needed i2c-isa seems to be compiled well according to kernel make
> output:
> >
> > CC      drivers/i2c/busses/i2c-isa.o
>=20
> There are no ISA slots on x86_64 motherboards, so no CONFIG_ISA option,
> but an ISA-like I/O space is still present so i2c-isa works.
>=20
> > Any idea how to get this working? :-)
>=20
> The output above strongly suggests that the W83627HF Super-I/O chip is
> not wired for hardware monitoring. As you can see, all values except
> V5SB and VBat are broken or missing.
>=20
> Given that the motherboard appears to have a dedicated hardware
> monitoring chip (W83793) it makes sense that Supermicro did not use the
> hardware monitoring functions of the Super-I/O. So you want to unload
> the w83267hf driver (or add ignore statements for everything but the
> two working voltage lines in sensors.conf) and load the w83793 driver
> instead. Except that this driver is new in 2.6.20, as can be seen on
> our wiki:
> http://www.lm-sensors.org/wiki/Devices
>=20
> So you'll need to upgrade your kernel before you can monitor the
> temperatures and fans on this motherboard.
>=20
> --
> Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
