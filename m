From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Jun 2011 15:48:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max1668) Add support for
Message-Id: <20110611174845.47d7b228@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110611112818.670e5db8@endymion.delvare>
In-Reply-To: <20110611112818.670e5db8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 11 Jun 2011 08:35:31 -0700, Guenter Roeck wrote:
> On Sat, Jun 11, 2011 at 05:28:18AM -0400, Jean Delvare wrote:
> > On Thu, 9 Jun 2011 18:14:07 -0700, Guenter Roeck wrote:
> > > root@groeck-desktop# sensors
> > > max1668-i2c-5-18
> > > Adapter: i2c-devantech-iss at bus 001 device 007
> > > temp1:        +23.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > > temp2:        +25.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > > temp3:        +25.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > > temp4:        +25.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
> > > temp5:          FAULT  (low  =3D -55.0=B0C, high =3D +127.0=B0C)    A=
LARM(MAX)
> > >=20
> > >  drivers/hwmon/max1668.c |   26 +++++++++++++++++++++++++-
> > >  1 files changed, 25 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
> > > index ddefb64..af85d44 100644
> > > --- a/drivers/hwmon/max1668.c
> > > +++ b/drivers/hwmon/max1668.c
> > > @@ -123,7 +123,7 @@ static struct max1668_data *max1668_update_device=
(struct device *dev)
> > >  		goto abort;
> > >  	}
> > >  	data->alarms &=3D 0x00ff;
> > > -	data->alarms |=3D ((u8) (val & 0x60)) << 8;
> > > +	data->alarms |=3D ((u8) (val & 0x70)) << 8;
> >=20
> > The (u8) type cast doesn't seem needed. Same a few lines below for
> > MAX1668_REG_STAT2.
> >=20
> Actually, turns out that
> 	data->alarms =3D val << 8;
> followed by
> 	data->alarms |=3D val;
> for MAX1668_REG_STAT2 is good enough.

I think that the original idea was to preserve as much of data->alarms
as possible in case one of the two reads failed. But given that the rest
of the driver code doesn't leverage from that, you can indeed simplify
it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
