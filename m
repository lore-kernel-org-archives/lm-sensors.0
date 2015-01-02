From: Eduardo Valentin <edubezval@gmail.com>
Date: Fri, 02 Jan 2015 19:03:41 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/8] thermal: Provide stub for thermal_of_cooling_device_register() funct
Message-Id: <20150102190339.GA22356@developer>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4025770607667836329=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-2-git-send-email-l.majewski@samsung.com>
 <20150102185426.GC12485@developer>
In-Reply-To: <20150102185426.GC12485@developer>
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============4025770607667836329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2015 at 02:54:28PM -0400, Eduardo Valentin wrote:
> On Mon, Dec 22, 2014 at 05:27:41PM +0100, Lukasz Majewski wrote:
> > Odroid U3 fan can work without being registered as OF cooling device
> > (with CONFIG_THERMAL_OF disabled).
> > In this situation it can be controlled via PWM entry at
> > /sys/class/hwmon/hwmon0/pwm1.
> >=20
> > Therefore, the thermal_of_cooling_device_register() function needs a st=
ub
> > to allow clean compilation.
> >=20
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>=20
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

Sorry, too fast,

This is actually
Nacked-by: Eduardo Valentin <edubezval@gmail.com>

:-)

I get this error:
drivers/thermal/thermal_core.c:1210:1: error: redefinition of
=E2=80=98thermal_of_cooling_device_register=E2=80=99
 thermal_of_cooling_device_register(struct device_node *np,
  ^
  In file included from drivers/thermal/thermal_core.c:34:0:
  include/linux/thermal.h:321:1: note: previous definition of
  =E2=80=98thermal_of_cooling_device_register=E2=80=99 was here
   thermal_of_cooling_device_register(struct device_node *np,
    ^


We provide the function in thermal core even if CONFIG_THERMAL_OF is not
set.
>=20
> > ---
> > Changes for v2:
> > - None
> > ---
> >  include/linux/thermal.h | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 2de3d9e..871123c 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -328,6 +328,10 @@ thermal_zone_of_sensor_register(struct device *dev=
, int id, void *data,
> >  				const struct thermal_zone_of_device_ops *ops);
> >  void thermal_zone_of_sensor_unregister(struct device *dev,
> >  				       struct thermal_zone_device *tz);
> > +struct thermal_cooling_device *
> > +thermal_of_cooling_device_register(struct device_node *np,
> > +				   char *type, void *devdata,
> > +				   const struct thermal_cooling_device_ops *);
> >  #else
> >  static inline struct thermal_zone_device *
> >  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
> > @@ -342,6 +346,13 @@ void thermal_zone_of_sensor_unregister(struct devi=
ce *dev,
> >  {
> >  }
> > =20
> > +static inline struct thermal_cooling_device *
> > +thermal_of_cooling_device_register(struct device_node *np,
> > +				   char *type, void *devdata,
> > +				   const struct thermal_cooling_device_ops *ops)
> > +{
> > +	return NULL;
> > +}
> >  #endif
> >  struct thermal_zone_device *thermal_zone_device_register(const char *,=
 int, int,
> >  		void *, struct thermal_zone_device_ops *,
> > @@ -357,9 +368,6 @@ void thermal_zone_device_update(struct thermal_zone=
_device *);
> > =20
> >  struct thermal_cooling_device *thermal_cooling_device_register(char *,=
 void *,
> >  		const struct thermal_cooling_device_ops *);
> > -struct thermal_cooling_device *
> > -thermal_of_cooling_device_register(struct device_node *np, char *, voi=
d *,
> > -				   const struct thermal_cooling_device_ops *);
> >  void thermal_cooling_device_unregister(struct thermal_cooling_device *=
);
> >  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *=
name);
> >  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned lon=
g *temp);
> > --=20
> > 2.0.0.rc2
> >=20



--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpuuBAAoJEMLUO4d9pOJW2YAH/2SAbMixX3p86V9hVE8xI6Pd
uBhGvlnOIcA1uB7zZpdp3e/gnXa5gIB9deHIyH8xtWcFoFGFk53ySv5cGMRnMjDs
6JDNgXkS8/XdFHc4wwB172CtzxFkKRsFDjt4wGeymOTQcSBr1lF49x0x1CNw7bbM
GynJ3MJ23gfijGmoC3v/DBGUp/gnqBCu2suGA8p7OlICFrE/9Qed6vmdj8vk6pKd
G2K85OqKcGzy4zoDiv7nkyZhy7w8U4/W6mNhQZExclpONrXJ0rjzdC8NgU1B0xIG
0RevLKqXtxYh1pugHqWvHxTdPVt49R7MT1wxi8vhIJRlY0scKRYsuyNJQsersrY=
=N8H8
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--


--===============4025770607667836329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4025770607667836329==--
