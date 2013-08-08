From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2013 17:15:54 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <20130808171554.GI6427@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8513450504014405422=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <20130808110136.GA6427@sirena.org.uk>
 <52038035.7030803@roeck-us.net>
 <20130808130840.GC6427@sirena.org.uk>
 <5203B78C.7010101@roeck-us.net>
In-Reply-To: <5203B78C.7010101-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org


--===============8513450504014405422==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zrGaLLVn9NtiuXI2"
Content-Disposition: inline


--zrGaLLVn9NtiuXI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2013 at 08:21:48AM -0700, Guenter Roeck wrote:
> On 08/08/2013 06:08 AM, Mark Brown wrote:

> >I'd be most surprised if the device worked without power, if the driver
> >fails to get and enable a regulator for it then that's not great
> >(especially if it does so silently).

> Correct, but it appears that the driver magically worked for a long time
> without it.

Sure, it'll work in systems that have always on regulators.

> Is it guaranteed that the driver keeps working for all cases where
> regulator support is enabled in the kernel, and where it used to work
> so far without mandating the existence of this specific regulator ?
> My main concern is having to deal with complaints that the driver stopped
> working for no good reason.

Sure, that's the transition issues I mentioned - the regulator API does
have stubbing facilities which should cover things and it's very easy to
define stub regulators if you need to.  Like I say I expect this to be a
lot easier after the next merge window as another way of doing stubs is
being added which should make this even easier by avoiding disrupting
drivers that do genuinely want to check for absent supplies and handle
that better.

> In this context, is it common practice to name such regulators "vdd"
> or similar ? What if there are multiple LM90 or compatible chips
> in a system, connected to different power rails ? Who determines
> if the regulator is supposed to be named "vdd" or "vcc" or anything
> else, and to which power rails it is actually connected ? How can
> and does one guarantee that "vdd" is the correct regulator to use
> for all systems ? What if some other driver requests "vdd", but the chip
> it supports happens to be connected to a different power rail ?

That's not what the name means - they are nothing to do with the board.
The names requested by a driver are defined with regard to the device
and should be the names used by the chip itself as defined in the
datasheet.  A board that uses regulators then maps these onto specific
regulators in the system, the driver doesn't need to know anything about
this process.

--zrGaLLVn9NtiuXI2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSA9JHAAoJELSic+t+oim9zEkP/AoqKLnVDfJ9xDiXXoDvTx3M
o+XVfEHrrPjBvy8YrVzQqoJJyvr8kPZzvSBBx//zwKdkWMfz6Lr/t/1bSA3Xi71t
uf2j9aODOPMIM63MBroJ+/QoQ/4JPhSAJBlpvb+lqu3V7VNNW4DHwoUUg6S7uZBm
n5C7yfEDHN9+/Wh8x8qWCoUMVfdjP9nAH2jxJgjCKwdk4Dyx5QJsEyqdCQ3IcIKF
wqbRwcfKA5KUsOtLb1EoXg5H2NEsXIM1bm/wkVBavm+VpdeWcDfRAg+Vnj7VFfPg
PBzx3jlv+OCEREkMQKTb90zqhYIuB4Q92aooSKCz7kMaavR40IiiYg7dSTtv5MF9
hHzDO/lBohYYDosH3STUNE5bA82GYFg+Pfm7cpKGAl99sTCGsWXnBg50syyfK1T7
t/BHU2cAeUMrnrLvelSmmpRXbCwtjHjK0xs3DWCnO4eX2oHGMfIHhwcus2NDm0rD
ukQV24FyZdVLCoQe9OLUof2OJvwZjBVVMsDVQVwdaFDmGQZ1XO92jCHVTEo3oKjQ
8dxDIme3x9LPyOslYxNZ4xRmCNwatCTxUJMaBpdIv8GPyL8C40iWrGZxC+YWkb5J
Q0n7+kTNNqoYVU4VO4jvLdC6UyCQ5uwgCGs23O/hmHkYKgUqkeQ+NYoJPduVk+sZ
RO0zgV3dTvvXmDNCEZ1F
=nJcN
-----END PGP SIGNATURE-----

--zrGaLLVn9NtiuXI2--


--===============8513450504014405422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8513450504014405422==--
