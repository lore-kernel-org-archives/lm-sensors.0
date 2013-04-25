From: Simon Guinot <simon.guinot@sequanux.org>
Date: Thu, 25 Apr 2013 09:58:16 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130425095816.GC17771@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7417850870209188082=="
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
In-Reply-To: <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Olivier Mouchet <olivier.mouchet@gmail.com>


--===============7417850870209188082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnaud,

On Wed, Apr 24, 2013 at 12:05:56AM +0200, Arnaud Ebalard wrote:
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> new file mode 100644
> index 0000000..810b019
> --- /dev/null
> +++ b/drivers/hwmon/g762.c

Snip

> +
> +/*
> + * Configuration-related definitions
> + */
> +
> +struct g762_config {
> +	u32 fan_startv;
> +	u32 fan_gear_mode;
> +	u32 fan_div;
> +	u32 fan_pulses;
> +	u32 fan_target;
> +	u32 pwm_polarity;
> +	u32 pwm_enable;
> +	u32 pwm_freq;
> +	u32 pwm_mode;
> +};
> +
> +/*
> + * g762 default values: it is assumed that the fan is set for a 32KHz clock
> + * source, a fan clock divisor of 1 and two pulses per revolution. Default
> + * fan driving mode is linear mode (g762/g763 also support PWM mode). Note
> + * the specific init value for properties which may be left unmodified.
> + */
> +#define G762_DEFAULT_CLK            32768
> +#define G762_DEFAULT_FAN_DIV        1
> +#define G762_DEFAULT_FAN_PULSES     2
> +#define G762_DEFAULT_OUT_MODE       0
> +#define G762_DEFAULT_FAN_MODE       2

Maybe you could use here the same macros as the ones used in the
do_set_* functions:

#define G762_DEFAULT_OUT_MODE		OUT_MODE_DAC
#define G762_DEFAULT_FAN_MODE		FAN_MODE_CLOSED_LOOP

Simon

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlF4/jgACgkQgtp0PDeOcDq62wCgl7iGqcPj31z3fECbIstxru8g
K30AmQGv5qYx32uLi12DzfzwA4SLfgyY
=4Mcw
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--


--===============7417850870209188082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7417850870209188082==--
