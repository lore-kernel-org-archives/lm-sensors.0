From: Simon Guinot <simon.guinot@sequanux.org>
Date: Sat, 27 Apr 2013 14:03:31 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130427140331.GL17771@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6934319372315071653=="
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
In-Reply-To: <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Olivier Mouchet <olivier.mouchet@gmail.com>


--===============6934319372315071653==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2013 at 12:05:56AM +0200, Arnaud Ebalard wrote:
> +	/*
> +	 * Set default configuration values before passing the structure
> +	 * to OF helpers to overload them using those provided by .dts
> +	 * file (if any). Final config is then commited.
> +	 */
> +	g762_config_init(&conf);
> +	g762_config_of_overload(client, &conf);
> +	err = g762_config_commit(client, &conf);
> +	if (err)
> +		goto out;

One more comment... Sorry for the multiple replies :)

I am not sure that applying a configuration anyway is a good idea.
I think it could be best to stick with the bootloader configuration if
no platform data nor device tree data are given.

Simon

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlF72rMACgkQgtp0PDeOcDqKzgCgoxI3Ogt80RkVuIrkdTOJl0xh
BbUAn0iI1jre5g5VzWZbeJxgB7Uk6DF9
=Ch3z
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--


--===============6934319372315071653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6934319372315071653==--
