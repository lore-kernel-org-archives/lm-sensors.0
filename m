From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Jan 2014 17:42:47 +0000
Subject: Re: [lm-sensors] sensors
Message-Id: <20140123184247.3f4ae3e7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
In-Reply-To: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 23 Jan 2014 08:41:01 +0100, Jean Delvare wrote:
> On Wed, 22 Jan 2014 20:59:30 -0800, Guenter Roeck wrote:
> > On 01/22/2014 03:27 PM, Ryan wrote:
> >  > radeon-pci-0100
> >  > Adapter: PCI adapter
> >  > temp1:       -128.0=B0C  (crit =3D +120.0=B0C, hyst =3D +90.0=B0C)
> >=20
> > This suggests that there is either no temperature sensor attached to
> > the graphics adapter (that is most likely), or that it is broken.
>=20
> First time I see this. I'd suggest that Ryan reports this to the radeon
> driver folks. I think all recent Radeon chips are supposed to have at
> least an internal thermal sensor. If I'm wrong then the ones which do
> not shouldn't instantiate a hwmon class device at all.

I have been explained that this is the expected result when the
graphics card is currently disabled. That would happen if the machine
has hybrid graphics and the other graphics chip was enabled at the time
the "sensors" command was run.

Returning something more sensible would be good, but I'm not too sure
what that would be... -EBUSY comes to mind but it's a bit misleading as
precisely the graphics chip isn't busy at all.

Anyway libsensors will translate all errors other than -EIO to
-SENSORS_ERR_ACCESS_R, so the exact error code doesn't really matter,
unless we also decide to extend libsensors to deal with it more
gracefully. Suggestions welcome.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
