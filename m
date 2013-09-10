From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Sep 2013 18:18:37 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <20130910181837.GD29403@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3445133251375512068=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130909155043.GA18975@roeck-us.net>
 <522E9059.3070305@nvidia.com>
 <522E93D6.2010304@roeck-us.net>
 <522E94AE.7000804@wwwdotorg.org>
 <522E97CE.4070300@roeck-us.net>
 <522E9C84.9070405@wwwdotorg.org>
 <20130910100939.GW29403@sirena.org.uk>
 <522F35BF.6070909@wwwdotorg.org>
 <20130910170438.GS29403@sirena.org.uk>
 <522F5A65.8040907@wwwdotorg.org>
In-Reply-To: <522F5A65.8040907-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--===============3445133251375512068==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U6tw7swXxW8PLjR9"
Content-Disposition: inline


--U6tw7swXxW8PLjR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 10, 2013 at 11:44:05AM -0600, Stephen Warren wrote:

> OK, so I believe you're saying that the case of a chip with just a
> single power source, which absolutely must be present in HW for the chip
> to be powered, isn't appropriate for regulator_get_optional(). Something
> must always define a regulator for that power source, even if there is
> no external SW control over that power source.

Well, it really should be mandatory - personally I don't think it's
sensible to add off-SoC chips without defining their regulators, it's
more trouble than it's worth to have to add them later for all the time
it takes to define the bindings.  In IETF terms it's a should.

> We either allow the regulator to be optional (since SW control over the
> regulator is optional), or go back to every board file and DT and add a
> dummy regulator in (which then breaks DT ABI, and even ignoring that is
> a pain).

The whole point of the way I'm changing the dummy support is to allow
us to gracefully cope with errors here so there's no mandatory update
even though strictly there should be one.

> And note that when I say "optional" at the start of the previous
> paragraph, I'm talking about probe-time regulator_get() operations and
> DT content. Clearly as far as the rest of the driver is concerned,
> something can always provide a dummy regulator so that e.g.
> regulator_enable/disable() elsewhere  always have something to operate
> on. However, probe() either needs to call an API that automatically
> provides such a dummy regulator, or open-code that itself. I'm still not
> clear which option you think should be used.

Clearly open coding this in every single driver is just not sane, you're
immediately in the situation where every single driver has to implement
the same thing at which point no driver ought to be doing it.

--U6tw7swXxW8PLjR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSL2J5AAoJELSic+t+oim94DQP/j6211xkmr+2ifS0E1iIyR+q
mSUCQnfH+FewIFfioHKR7d27crNBJQePTz9ilBkTkeCn/aAI/rWRVNs49qKubP23
hVvf4RmEJURxDRqVfUBMHijz5muRD7bHhWPgldlT8KNG2GK1A0XqgGsZ4lUJ5VzD
tenA6Detv823xRzxHCsbJBF6Zb0dx1zvJSadr3+DxfKdlfRX5Kn/g7YpOFNm8KLQ
sORPUtItQGoPi+qzX9zfAgZqLInnuu+Dh08V9u+KBW6y60+VTUrUIO4rWG7hkUib
6sTrzw+6dpl9iS/WMYtqYug/vrSIWyQJIFQJ+F7sH8GGlxAtQxQBY7um3h+Gjo7w
EB2Oc8GsyCXD3aLpejQDZhCttSXnE1PX7u/4leVzmNQn3ZwLh7m/9KhgVZ5KBwc8
+x21Sxhv3htA/QsJR/QdyYtTkUlND1t8dMeWriupjKrWE8a+gP2c2DZkGcyy8zCh
XpfzzCZmWcFNX6u8DyFhaEnEz0VagZtx1ONb2cTas6/OBjp1AUXpxCMmnLVrKMcY
r7gOv/ew0tSIL+JOC+g8vaYq9VW02xf9qoH4r2cGdRR9GmdQ/6e8L7TSoop9xVkk
1Gfd5LT+OxuHjHCmnVYAWekFYfnVDhx+qEBTqI+NsIFq3STSvUXRHtV0Ttj8ACNB
pAFIJ+3MVlIXjOxEbkjX
=snar
-----END PGP SIGNATURE-----

--U6tw7swXxW8PLjR9--


--===============3445133251375512068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3445133251375512068==--
