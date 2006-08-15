From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Aug 2006 08:01:30 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060815100130.6cd0b6f6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Mark, David,

> > The w83627ehf driver uses struct sensor_device_attribute instead of
> > struct device_attribute, and we've put them in arrays, so if I created
>=20
> The only reason to put them in arrays in the first place was to make
> registration easier.  For w83627ehf, I would do this...
>=20
> -static struct sensor_device_attribute sda_in_input[] =3D {
> -	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
> -	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
> -	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
> -	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
> -	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
> -	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
> -	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
> -	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
> -	SENSOR_ATTR(in8_input, S_IRUGO, show_in, NULL, 8),
> -	SENSOR_ATTR(in9_input, S_IRUGO, show_in, NULL, 9),
> -};
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 4);
> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in, NULL, 5);
> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in, NULL, 6);
> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in, NULL, 7);
> +static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in, NULL, 8);
> +static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_in, NULL, 9);

Yep. The driver core wants arrays of pointers, rather that arrays of
structures. We have to adapt.

> > a struct attribute *w83627ehf_attributes, it would contain something
> > like &sda_sf3_arrays[0].device_attr, &sda_sf3_arrays[1].device_attr,
>=20
> Given the above, it would be &dev_attr_in0_input.dev_attr.attr.
>=20
> > I think that would be ugly code. It would allow me to call
> > sysfs_create_group() just like Mark does, which I would do if I could
> > find a way. Is there a sysfs_create_* function that takes
> > sensor_device_attribute arrays instead? If I read correctly, no. :-(
>=20
> Of course we could create one and put it into the hwmon module.  Not sure
> if I like that idea though.  It won't save any code, and I don't think it
> would save any time either.

There are currently 3 possible structures for device attributes in
hardware monitoring drivers, depending on whether they take 0, 1 or 2
parameters. Some drivers mix the three types. Having helpers for arrays
of structures would mean 3 different function sets in the hwmon driver,
and some drivers would have to call the three of them. This is going to
make things much more complex in some cases.

So I'd rather stick to what the driver core offers. Arrays of pointers
make it possible to handle all attributes in a single array, regardless
of their "original type".

And indeed, the few drivers which had been using arrays for attributes
will have to change. I'm sorry about that, but this seems to be the
best move in the long run.

Now, the usual rules apply. If someone comes up with real working code
and real world numbers which prove me wrong, the discussion reopens.

> I2C developers =3D mostly Jean, increasingly me too.  Anyway, i2c-isa is
> not used by anyone except hwmon, so it's just as well to discuss it here.

Yup, in fact i2c-isa should be in drivers/hwmon. I didn't bother moving
it only because it was planned for removal anyway.

> Jean: I thought you already had such a patch in your queue?  Now I can't
> seem to find it.

No, I don't. Maybe you are thinking of your own "i2c algorithm drivers
don't propagate bus creation error" patch [1] or my work-in-progress
patch addressing the __must_check warnings in i2c-isa [2]. But the
specific bug reported by David is new to me.

[1] http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommit;h=B39ad0cf7c19fc14e8f823b1b36245f7a3711655
[2] http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-core-__must_check-fix=
es.patch

Thanks,
--=20
Jean Delvare

