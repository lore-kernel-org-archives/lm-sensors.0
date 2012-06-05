From: "Ger vermeulen" <geve002@casema.nl>
Date: Tue, 05 Jun 2012 21:05:23 +0000
Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces wrong values with lm-sensors 3.3.2
Message-Id: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgUKFAAAQAAAAmJc5it0UoUamRX3LRiC2TQEAAAAA@casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> sensors.org] On Behalf Of Guenter Roeck
> Sent: Tuesday, 05 June, 2012 22:34
> To: geve002@casema.nl
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces
> wrong values with lm-sensors 3.3.2
>=20
> On Tue, 2012-06-05 at 15:10 -0400, Ger vermeulen wrote:
>=20
> [ ... ]
>=20
> >
> > The workaround you suggested to change the tjmax is not possible for my
> > coretemp.ko unknown symbol.
> >
> Not sure I understand. What command do you execute, and what exactly is
> the output ?
>=20
> > So a work around can be adding to /etc/sensors3.conf
> >
> > chip "coretemp-isa-0000"
> >      label temp1 "Core0"
> >      compute temp1 @+35,@-35
> >
> > chip "coretemp-isa-0001"
> >      label temp1 "Core1"
> >      compute temp1 @+35,@-35
> >
> > Is this correct?
> >
> It shows you the correct temperature. So, yes, it is one way to solve
> the problem. Do you really need the "label" line ?
>=20
> Thanks,
> Guenter
>=20
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



root@atom:~# insmod
/lib/modules/2.6.37.6-smp/kernel/drivers/hwmon/coretemp.ko tjmax=3D125
insmod: error inserting
'/lib/modules/2.6.37.6-smp/kernel/drivers/hwmon/coretemp.ko': -1 Unknown
symbol in module

The "label" line I copied from another example, not knowing what the exact
syntax should be. I assumed a kind of definition of the temp object.
Without the "label" line it works as well, so don't need it.

After removal of label it looks like this:

root@atom:/etc# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +38.0=B0C  (crit =3D +125.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:       +49.0=B0C  (crit =3D +125.0=B0C)

Thanks, Ger


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
