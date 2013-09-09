From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Sep 2013 11:12:42 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <20130909111242.GW29403@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0390040824934813479=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com>
 <1378722552-10357-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1378722552-10357-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--===============0390040824934813479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eGyD7iWN192kf2IJ"
Content-Disposition: inline


--eGyD7iWN192kf2IJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2013 at 06:29:11PM +0800, Wei Ni wrote:

> +	reg = devm_regulator_get_optional(dev, "vcc");
> +	if (!IS_ERR(reg)) {
> +		err = regulator_enable(reg);
> +		if (err < 0) {
> +			dev_err(&client->dev,
> +				"Failed to enable regulator: %d\n", err);
> +			return err;
> +		}
> +		msleep(25);
> +	} else {
> +		if (PTR_ERR(reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}

This doesn't look good, it is going to ignore actual errors - I *really*
doubt that vcc is optional, it looks like it's the main power supply for
the device.  You should use normal regulator_get(), _optional() is for
supplies which could physically not be provided in a system (eg, if the
device can generate them internally if required).

Also do you really need 25ms after power on?

--eGyD7iWN192kf2IJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLa0mAAoJELSic+t+oim9mtEP/1SUDSgzujFw5/vaUxTB6Jq/
PwuLrmNO0Qn6UGFgEedeVtxF8sFiw/lQwE9BxjI/31HaLpMIzhW7jyWTclCcfHLm
8sEkFEF8uQfMXR613Z/dBaDhX2cpv7GxrYT1BTJEyAJ8SsUqoHlTZfW2zQtmCV2y
cMKB7pxHx6sbu4bfyPqy3n0C8Z3O5hO2toh3cnGMs6ykw2SXLC2MRqlNeOkrTFHW
sYf6U9Di6V+r6CTU+hkWlAA9Z6EK34K1W03hVwy2Uxt/7JQXPJstRteeCaQkMoOy
Nh3aZr9ndD0mLWQOlZPTdZFgWEXWoSMMd5cp1sIHCgSouIAmgNWtYm6xeMqHeMX8
QW302r0sG2cFNHR8s9WxXmkqxU/zaNJSndTCbz9+2JMri3oDTa1h/17lYmEhAmeU
nRZdWf0vCUt3xFcmXLOLJGh/+6wfeG5grOjCZ2ak1iK/Hg8AZBW8baqDpSQoNdbe
aZwnQ1XWUFr6x41CXOY2gAo+cHewD6xCmbUMaNZ1Hw609cCtzUyH4RJk4WdCD6nR
HL2nXGJ0eBuej+oVFWuYpgN7nfaLEgD0O6ltbkQ/Gy2EcJKiQ0pnXJVUonCo2tmz
LaxRZv5XyqFWh5fkfqeWN+yoiSLytn69nv/wL37DfuAII8MkusNIGLfovIc5Lw1L
sy023tGgup8IypqiDFB0
=cjg2
-----END PGP SIGNATURE-----

--eGyD7iWN192kf2IJ--


--===============0390040824934813479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0390040824934813479==--
