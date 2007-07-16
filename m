From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 20:18:56 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070716201855.GC2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8377061095277354178=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============8377061095277354178==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 14, 2007 at 04:23:16PM +0200, Vadim Zeitlin wrote:
>  The first thing I noticed is that accessing any of them takes almost 3
> seconds:
>=20
> # time cat fan1_input
> 2001
> cat fan1_input  0.00s user 0.00s system 0% cpu 2.760 total

Hm.... I see this with the v3 patch:
root@elm3a181:/usr/local/src/lm_sensors-2.10.3/prog# time cat
/sys/class/hwmon/hwmon0/device/temp1_input=20
47000

real    0m1.701s
user    0m0.000s
sys     0m0.000s

Not sure why it takes 700ms to read the sensors after the 1s sleep,
perhaps that could just be the cost of reading the registers?  (I'd hope
not...)

> I wonder if this is normal? I see a 1 sec sleep in adt7470_update_device()
> but the delay happens not only for the temperatures and it's also much
> bigger than 1 second.
>=20
>  Next, the fan speed detection seems to work as expected, i.e. the number
> it gives (like 2000 above) seem to be RPM. But reading the temperature
> files produces strange results:
>=20
> # grep . temp?_input
> temp1_input:0
> temp2_input:228000
> temp3_input:59000
> temp4_input:54000
> temp5_input:226000
> temp6_input:228000
> temp7_input:58000
> temp8_input:54000
> temp9_input:49000
>=20
> Again, I see the factor of 1000 in adt7470.c and, accounting for it, all

Documentation/hwmon/sysfs-interface says that the units for temperatures
are millidegrees C, hence the 1000 factor both here and for the pwm
controls below.

> numbers except 227000 may be correct -- but what about those latter ones?
> To confuse the matters (or at least me) further, temp_min files contain
> 129000 while temp_max files have 127000 (no typo) so something seems wrong

Mine are programmed like that too.  I suppose it's possible that the
datasheet could be wrong?  Page 14 of the adt7470 datasheet says that
the default temp low limit is 0x81 and the default temp high limit is
0x7F.  Weird...unless I'm misinterpreting the data sheet?

> here... At the very least, the factor of 1000 seems to be unnecessary:
>=20
> # grep . pwm1*
> pwm1:0
> pwm1_auto_channels_temp:1023
> pwm1_auto_point1_pwm:128
> pwm1_auto_point1_temp:90000
> pwm1_auto_point2_pwm:255
> pwm1_auto_point2_temp:110000
> pwm1_enable:2
>=20
> The values here clearly should be 90 and 110 degrees, shouldn't they?

(See above)

--D

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm9Kva6vRYYgWQuURAm0wAJ9JPKIViRvz9kOb/Eoe2ftxYvFmjwCbBURn
uzIwsGffINF3ozeHRLyJt3g=
=YLDx
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--


--===============8377061095277354178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8377061095277354178==--
