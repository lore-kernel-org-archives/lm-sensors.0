From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 14:15:12 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101026161512.5faf1785@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Clemens,

On Tue, 26 Oct 2010 15:53:29 +0200, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > > > Doh. You are aware that Core i7 CPUs are made by Intel and Family 1=
0h
> > > > (aka K10) CPUs are made by AMD, aren't you? They are different CPU
> > > > models, they don't have to be designed the same way.
> > >=20
> > > I know that :)
> > > I thought maybe that is a standard and each cpu temperature must be s=
how
> > > separetly.
> >=20
> > There is no such standard.
>=20
> And on the newest CPUs, Intel has switched to one temperature sensor per
> package.

Really? Starting with which CPU model?

> > On Tue, 26 Oct 2010 06:06:53 -0700 (PDT), Mahmood Naderan wrote:
> > > One more question, Is it possible to find out which two modules are t=
ied to one=20
> > > processor?
> >=20
> > Modules?
> >=20
> > > Currently there are:
> > > k10temp-pci-00c3
> > > temp1:       +27.0=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C)
> > > k10temp-pci-00cb
> > > temp1:       +27.0=B0C  (high =3D +70.0=B0C)
> > > k10temp-pci-00d3
> > > temp1:       +26.0=B0C  (high =3D +70.0=B0C)
> > > k10temp-pci-00db
> > > temp1:       +26.0=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C)
> > > =20
> > > Is it true that [00c3 and 00cb] are for one physical cpu and [00d3 an=
d 00db] are=20
> > > for the other cpu?
>=20
> I conclude from this question that you have two CPUs, and that each CPU
> has two temperature sensors.
>=20
> The temperature sensor is part of the PCI device that associated with
> the CPU's internal northbridge.  IIRC the six-core CPUs have two
> northbridges, for whatever technical reason, so they present two
> temparature sensors to the OS.
>=20
> It looks as if the two sensors in each CPU have the same value.  Is this
> always the case?
>=20
> (I don't know where the c3/cb/d3/db names come from.)

This is the PCI bus number in compact hexadecimal form:

00:18.3 -> 00c3
00:19.3 -> 00cb
00:1a.3 -> 00d3
00:1b.3 -> 00db

We had to find a unique ID to differentiate between them, and that ID
had to fit in an int to make libsensors happy.

> > All entries in cpuinfo look the same, so I can't explain why some have
> > the critical limit and some don't.
>=20
> The limit is set by the BIOS.  I'd guess the BIOS knows that two sensors
> are actually the same, an so doesn't bother to set the limit on the
> superfluous ones.
>=20
> I'll look into the datasheet to see if this situation (two northbridges
> per CPU) is documented and can be detected so that the driver can ignore
> these superfluous sensors.

If these sensors exist, I see no valid reason to ignore them. Two
sensors can be useful, to slightly increase the resolution by combining
them, or simply in case one of them get unreliable for whatever reason.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
