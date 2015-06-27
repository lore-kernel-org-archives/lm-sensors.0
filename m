From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date: Sat, 27 Jun 2015 12:55:40 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <5861345.suUcko3aRb@xps13>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150428123850.GA8855@kroah.com> <3228158.O80YglnvCi@xps13> <201506271447.16248@pali>
In-Reply-To: <201506271447.16248@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Saturday 27 June 2015 14:47:16 Pali Roh=E1r wrote:
> On Saturday 27 June 2015 13:34:30 Gabriele Mazzotta wrote:
> > Hi Pali,
> >=20
> > I've just noticed an issue with this patch. See the comment here
> > below.
> >=20
> > Gabriele
> >=20
> > On Wednesday 29 April 2015 13:41:26 Pali Roh=E1r wrote:
> > > @@ -750,8 +777,8 @@ static int __init i8k_init_hwmon(void)
> > >=20
> > >  	if (err >=3D 0)
> > >  =09
> > >  		i8k_hwmon_flags |=3D I8K_HWMON_HAVE_FAN2;
> > >=20
> > > -	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL, "i8k",
> > > NULL, -							  i8k_groups);
> > > +	i8k_hwmon_dev =3D hwmon_device_register_with_groups(NULL,
> > > "dell-smm", +							  NULL, i8k_groups);
> >=20
> > dell-smm is not a valid name, see hwmon_device_register_with_groups()
> > for more info (dash not allowed). Because of this, the driver can't
> > be loaded.
> >=20
>=20
> How it is possible? It worked fine on my tested dell machine...
>=20
> And now I see, I probably tested this change with older kernel version=20
> (ubuntu/3.13) which did not have that check for invalid characters...
>=20
> Renaming dell-smm to dell_smm should fix this problem, right?

Yes, everything works just fine with the underscore.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
