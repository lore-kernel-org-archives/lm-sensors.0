From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jan 2013 22:00:58 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <20130107230058.2721101e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Leslie,

On Mon, 7 Jan 2013 15:01:19 -0600, Leslie Rhorer wrote:
>=20
>=20
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > Sent: Monday, January 07, 2013 2:49 AM
> > To: Leslie Rhorer
> > Cc: lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
> > (...)
> > Builds just fine for me. Please make sure all files are still using
> > Unix (not DOS) line ending. Also make sure that you have installed all
> > packages your distribution provides for kernel building.
> > http://khali.linux-fr.org/devel/misc/INSTALL has suggestions on what
> > may be needed. I'll be happy to update that file if something is
> > missing and you can figure out what it is.
>=20
> 	The one glaring thing from the web page was /lib/modules/$(uname
> -r)/build did not exist.  I created the link, and the make worked, so we'=
re
> moving right along.
>=20
> 	The `sensors command was finding ISA targets, but none other, so I
> also downloaded and compiled k10temp and hwmon-vid.  Here is the output n=
ow:
>=20
> RAID-Server:/tmp# sensors
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +2.81 V  (min =3D  +1.04 V, max =3D  +1.99 V)  ALARM
> in1:          +2.81 V  (min =3D  +1.08 V, max =3D  +2.48 V)  ALARM
> in2:          +0.90 V  (min =3D  +2.34 V, max =3D  +0.72 V)  ALARM
> +3.3V:        +3.29 V  (min =3D  +2.33 V, max =3D  +1.87 V)  ALARM
> in4:          +1.54 V  (min =3D  +0.06 V, max =3D  +1.70 V)
> in5:          +2.51 V  (min =3D  +2.40 V, max =3D  +2.92 V)
> in6:          +1.54 V  (min =3D  +0.12 V, max =3D  +0.58 V)  ALARM
> 3VSB:         +3.46 V  (min =3D  +5.06 V, max =3D  +1.34 V)  ALARM
> Vbat:         +3.38 V =20
> fan1:           0 RPM  (min =3D   14 RPM)  ALARM
> fan2:        2213 RPM  (min =3D   32 RPM)
> fan3:        2191 RPM  (min =3D   11 RPM)
> temp1:        +32.0=B0C  (low  =3D +36.0=B0C, high =3D +11.0=B0C)  ALARM =
 sensor =3D
> thermistor
> temp2:        +31.0=B0C  (low  =3D  +0.0=B0C, high =3D +49.0=B0C)  sensor=
 =3D thermistor
> temp3:       -128.0=B0C  (low  =3D +116.0=B0C, high =3D +93.0=B0C)  senso=
r =3D disabled
> intrusion0:  OK
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +10.2=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +90.0=B0C, hyst =3D +87.0=B0C)
>=20
>=20
> 	Obviously, I need to do some editing of /etc/sensors.conf, but how
> do I know which parameter is which?  The fans are pretty easy (just
> disconnect one and see which fan drops to 0 RPM), but which temperature is
> which device?  Temp1 and temp2 on it87 look almost reasonable (I think the
> temps are somewhat higher),

Indeed.

> but temp1 on k10temp obviously is not, so it
> would seem it requires some computation, but using what values?

AMD CPU sensors are notoriously off, and even more so in low
temperature ranges. Do not see the above as 10.2=B0C but just as "there's
a lot of thermal margin up to the high limit" i.e. your CPU cooling is
very efficient.

> Is temp3 on it87 really not in use?

I'd say it's not used indeed.

>  Should I try changing the sensor type on temp1 of
> k10temp?=20

You can't, k10temp is a digital sensor inside the CPU, there's no type
to change.

> What about the temp1 and temp2 sensors on it87?

You can try putting some load on the CPU to see if any of these
correspond to the CPU temperature (it would rise faster.)

> 	Additionally, there are 5 fans on this machine (actually, one is a
> pump, but the MB doesn't know that), and all 5 are spinning and attached =
to
> the motherboard sensors.  The `sensors` command is only reporting three, =
and
> one of those is said to be stalled.  'Any ideas how I can fix the fan1
> report and access the other fans?

No idea. Some boards use multiplexing for that but I am not aware of
Asus doing that. There could be another chip for fan speed
monitoring/control on the board. Or the IT8721F chip is improperly
configured (after all the chip _does_ support up to 5 fans...)

Do you see all fan speeds in the BIOS? If you do, and go from the BIOS
to Linux directly (assuming the system support that), does it help?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
