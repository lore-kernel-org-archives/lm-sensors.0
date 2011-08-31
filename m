From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Aug 2011 08:33:22 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Make LM73 detection less
Message-Id: <20110831103322.5ab6d662@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110830221914.6701f812@endymion.delvare>
In-Reply-To: <20110830221914.6701f812@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 30 Aug 2011 13:31:40 -0700, Guenter Roeck wrote:
> On Tue, 2011-08-30 at 16:19 -0400, Jean Delvare wrote:
> > Same idea as the change just made to the lm73 driver itself: do as
> > much detection as possible with byte reads.
> >=20
> > Index: prog/detect/sensors-detect
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > --- prog/detect/sensors-detect	(r=E9visio=
n 5993)
> > +++ prog/detect/sensors-detect	(copie de travail)
> > @@ -4044,7 +4044,9 @@
> >  	# Bits that always return 0
> >  	return if ($conf & 0x0c) or ($status & 0x10);
> > =20
> > -	return if i2c_smbus_read_word_data($file, 0x07) !=3D 0x9001;
> > +	# Test with byte read first to avoid confusing other chips
> > +	return if i2c_smbus_read_byte_data($file, 0x07) !=3D 0x01
> > +	       or i2c_smbus_read_word_data($file, 0x07) !=3D 0x9001;
> > =20
> >  	# Make sure the chip supports SMBus read word transactions
> >  	my $cur =3D i2c_smbus_read_word_data($file, 0x00);
> >=20
> >=20
> Looks good.=20
>=20
> Reminds me - would be great if you could find the time to comment on the
> sensors patch I sent out a while ago (adding support for the new sysfs
> attributes).

Still on my long to-do list :( thanks for the reminder.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
