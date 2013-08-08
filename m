From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2013 11:01:36 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Add power control
Message-Id: <20130808110136.GA6427@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3846366114183228476=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
In-Reply-To: <1375944991-29182-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org


--===============3846366114183228476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uT8OcDz013Sgpw/5"
Content-Disposition: inline


--uT8OcDz013Sgpw/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2013 at 02:56:29PM +0800, Wei Ni wrote:

> +	mutex_lock(&data->update_lock);
> +
> +	if (is_enable)
> +		ret = regulator_enable(data->lm90_reg);
> +	else
> +		ret = regulator_disable(data->lm90_reg);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Error in %s rail vdd, error %d\n",
> +			(is_enable) ? "enabling" : "disabling", ret);
> +	else
> +		dev_info(&client->dev, "success in %s rail vdd\n",
> +			 (is_enable) ? "enabling" : "disabling");
> +
> +	mutex_unlock(&data->update_lock);

Two things here.  One is that it's not clear what this lokc is
protecting since the only thing in the locked region is the regulator
operation and that is thread safe.  The other thing is that I'm not
seeing anthing that ensures that enables and disables are matched -
regulators are reference counted so two enables need two disables.

> +	data->lm90_reg = regulator_get(&client->dev, "vdd");
> +	if (IS_ERR_OR_NULL(data->lm90_reg)) {

NULL is a valid regulator, use IS_ERR().

> +		if (PTR_ERR(data->lm90_reg) == -ENODEV)
> +			dev_info(&client->dev,
> +				 "No regulator found for vdd. Assuming vdd is always powered.");
> +		else
> +			dev_warn(&client->dev,
> +				 "Error [%ld] in getting the regulator handle for vdd.\n",
> +				 PTR_ERR(data->lm90_reg));

You shouldn't just be ignoring errors here, though there are deployment
difficulties with making sure a stub regulator is provided.  These
should be getting easier after the next merge window, the stubs will be
being tweaked slightly to have an "assume it's there" option even when
regulators are used.  Especially in cases with device tree you should be
paying attention to -EPROBE_DEFER, that will accurately reflect if a
regulator is present but not loaded yet.

That said if you *are* going to do this you should request the
regulator using devm_regulator_get_optional(), this is intended to
support things that don't need regulators (though that's not the case
here).

--uT8OcDz013Sgpw/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSA3qNAAoJELSic+t+oim9glQP/0z1b5xAw7AUj74owA9E/qHC
NSXv4/bK/EnkWOtBznNOTaW/HttDJWNkaUCQokY8ekRKreZw+GrvAUUnkh3jFMtN
079QSAhr8JiNdDdsGdj/uaOHnVDbfmFCqmg0qX+mYWzEJIGn9Ew9gjkDx3bv/jwU
SFQGHJ0BRkHyCUq/xwrODpKVwKzR512QzGazKzooMhKqxFpTQauHQvGQJlmGm512
DWZ9WbZKQfI47rx7McuwkGc4PFYx3uwAr2287/D/2lJT0r7CZBFahb0MjmoioRr3
j/zVxczE7WhiKWQDD5YQ4uphsMPYjYYruaouYrs0vtfInRRNuZ5hqIiRsUznhjAL
EQuunC1hG0DXJErFGVdjc3seGVTjQtXsJq+aC7uCghSW1T4SRoHx71BAL8NQzgpE
9Dz67JG/LJt4IxUdCqW8/zwMlb23gyXcKNFF+NRDQZ9lF9bi6n4gP5jMcEH2AfWE
6OS5VfV5kNuQFHUj3FN9DP9Vv5C5Tlx70HjWuUEmUFgtoK5BdglRvWhtY+u7Jo2P
lJcIo7krQs6/2ihKAKiEShIU5biIiE6sx7fOWZw0qVOV6EOIejL9urN2FCBfNAll
jAO44psuQDJB/b/yWlQG1cqynzh1jOOGDhaAREDFCZVZhlFnKdNzo7fgujpxeSCI
HQkHyyn5mBW0nAnWd0g2
=q1TX
-----END PGP SIGNATURE-----

--uT8OcDz013Sgpw/5--


--===============3846366114183228476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3846366114183228476==--
