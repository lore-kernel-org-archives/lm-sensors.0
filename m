From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Mon, 07 Jan 2013 23:54:23 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <201301072354.r07NsNUm007748@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Monday, January 07, 2013 4:01 PM
> To: Leslie Rhorer
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
> > temp1:        +32.0=B0C  (low  =3D +36.0=B0C, high =3D +11.0=B0C)  ALAR=
M  sensor =3D
> > thermistor
> > temp2:        +31.0=B0C  (low  =3D  +0.0=B0C, high =3D +49.0=B0C)  sens=
or =3D
> thermistor
> > temp3:       -128.0=B0C  (low  =3D +116.0=B0C, high =3D +93.0=B0C)  sen=
sor =3D
> disabled
> > intrusion0:  OK
> >
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > temp1:        +10.2=B0C  (high =3D +70.0=B0C)
> >                        (crit =3D +90.0=B0C, hyst =3D +87.0=B0C)
> >
> >
> > 	Obviously, I need to do some editing of /etc/sensors.conf, but how
> > do I know which parameter is which?  The fans are pretty easy (just
> > disconnect one and see which fan drops to 0 RPM), but which temperature
> is
> > which device?  Temp1 and temp2 on it87 look almost reasonable (I think
> the
> > temps are somewhat higher),
>=20
> Indeed.
>=20
> > but temp1 on k10temp obviously is not, so it
> > would seem it requires some computation, but using what values?
>=20
> AMD CPU sensors are notoriously off, and even more so in low
> temperature ranges. Do not see the above as 10.2=B0C but just as "there's
> a lot of thermal margin up to the high limit" i.e. your CPU cooling is
> very efficient.

	Hmm.  Ok, that may explain the behavior of the PCI sensor I reported
in the subsequent message.  Perhaps the temperature needs to be higher
before the sensor is stable?  The actual temperature is about 45=B0C accord=
ing
to an IR thermometer.

> > What about the temp1 and temp2 sensors on it87?
>=20
> You can try putting some load on the CPU to see if any of these
> correspond to the CPU temperature (it would rise faster.)

	Well, I tried that, but both temp1 readings soar.  OTOH, I did not
notice the it87 temp1 reading going up when I shut off the Coolant fan.
With all 8 cores running greater than 25% and two of them running more than
50%, the it87 temp1 is running around 51=B0C and the k10temp temp1 is about
41=B0C.  I'll shut down the server in a few minutes and see what the BIOS
reports.

> > 	Additionally, there are 5 fans on this machine (actually, one is a
> > pump, but the MB doesn't know that), and all 5 are spinning and attached
> to
> > the motherboard sensors.  The `sensors` command is only reporting three,
> and
> > one of those is said to be stalled.  'Any ideas how I can fix the fan1
> > report and access the other fans?
>=20
> No idea. Some boards use multiplexing for that but I am not aware of
> Asus doing that.

	That might tend to explain the sensor reports jumping about as I
reported=20

> Do you see all fan speeds in the BIOS? If you do, and go from the BIOS

	As I recall, yes.  A couple of them were off the chart, however.  I
presumed it indicated a bad divisor.

> to Linux directly (assuming the system support that), does it help

	I don't understand what you mean.  Do you mean bypassing GRUB?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
