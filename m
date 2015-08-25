From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 25 Aug 2015 16:18:50 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <20150825161850.GA8118@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4598595078097161200=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150825052513.GI1654@sirena.org.uk>
 <20150825145756.GA4066@schokonusskuchen.bad>
 <55DC8746.1060809@roeck-us.net>
In-Reply-To: <55DC8746.1060809-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dustin Byford <dustin-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>


--===============4598595078097161200==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2015 at 08:18:30AM -0700, Guenter Roeck wrote:
> On 08/25/2015 07:57 AM, Wolfram Sang wrote:
> >On Tue, Aug 25, 2015 at 06:25:13AM +0100, Mark Brown wrote:
> >>On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:
> >>>Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
> >>>slaves") broke the lm-sensors which relies on I2C hwmon slave devices =
under
> >>>/sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
> >>>devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and s=
ysfs
> >>>code in lm-sensors does not find them anymore:
> >>
> >>Acked-by: Mark Brown <broonie@kernel.org>
> >
> >Don't you think there will be regressions given that the new naming
> >scheme was around for 18 months?
> >
>=20
> acpi is pretty long term. New bindings don't show up quickly.

The key is, there might be userspace applications that got used to our
new "export" of ACPI bindings. The bindings were already existing, our
"export" did change.

> So I am not surprised that this only shows up now.

I am, to be honest. It shows running lm-sensors with ACPI on a kernel
newer than 18 months. Not a rare scenario, so I thought.

> Will there be regressions ? Who knows. What we do know is
> that there are regressions today due to the original change.

Because we didn't pay enough attention. I wouldn't like to do the same
mistake again. Or?


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3JVqAAoJEBQN5MwUoCm2YAUP/3e0qJqVtkPVvmSu+ZIQ8VU8
AwkYZO5TJE3UCBJgRRGXe6FqLA8pA+UDvlPmrIXouYUi6ePcTo0dFMf2i4vMhTt8
NZlfirt9FKa3ahmnuZgdXsWU6gZbVCbhsByh46l8EDRjn2hSHdl9GkD3QxLQn/h5
Ms8mfujq0GPOW8cFOBQb/QYnhT04XWUy2ndUkzMJrrlrGJpoV8rQcYAfGfYCzLsZ
tj19l0MmR39koJ0lL8Ri7Ulty18T/jzPVPA13VhV8JGwMVIP5ZlQsrvNzAAkrfgt
5eehDdcWW8snmpJ/ATnf6qFH2dyRaXXGDL/DTlkXO/0zzm+sZwIGaCoAwqjhGxt/
+/lItH8GQp2L2c9SYR6q7Cq+xcFrFR8D7xS/54VBJodV7y3SYZLcZsdpO5ial4Bs
G/LhqBWfO2oJVgXndoKsvaU2YZ+jtGWiQwdOblhNDe1wWvyBTNxFG1dP+GzmxYgh
un4IId4YDUKbDkd0atG1XMPio+GG8QFsWsmQBql9trvQQ7qchx72gxlATzT5AxjO
GFUoNID0FFKHmpVA1nzbzPOv0AIcX0h5ghbi02UjfAl1MwKOkYISn5WBamg1YmvO
kOMBc9XG9jSntMHaY5FQsLjZRjBYfQyj8wFn9S4ZVtrhoGAdPwtg+28/SzGXhzu7
Un8b3hAMbfqZgzUcjYhY
=yiqx
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--


--===============4598595078097161200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4598595078097161200==--
