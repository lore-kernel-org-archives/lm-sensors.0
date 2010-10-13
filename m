From: Simon Guinot <simon@sequanux.org>
Date: Wed, 13 Oct 2010 11:59:51 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: DNS323 rev C1 fan support
Message-Id: <20101013115951.GA5649@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4857716558040823601=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1274525694.1931.142.camel@pasglop>
In-Reply-To: <1274525694.1931.142.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org


--===============4857716558040823601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Benjamin,

What is the status for the DNS323 fan support ?
Have this patch been merged yet ?

I am currently looking to add hwmon support for the GPIO fan found
on Network Space Max v2 boards. Obviously, some attributes are shared
with the DNS323 fan. Maybe there is some room for a generic GPIO fan
driver ?

Platform data could provide the board specific GPIO pinout and a speed
conversion array (rpm from/to GPIO value). Here is a proposal for this
platform data interface:

struct gpio_fan {
        const char      *name;
        unsigned        gpio;
        unsigned        active_low;
};

struct gpio_fan_speed {
        int value;
        int rpm;
};

struct gpio_fan_platform_data {
        struct gpio_fan         *alarm; /* fan alarm GPIO. */
        struct gpio_fan         *ctrl;  /* fan control GPIOs. */
        int                     num_ctrl;
        /*
         * Speed conversion array: rpm from/to GPIO bit field.
         * This array _must_ be sorted in ascending rpm order.
         */
        struct gpio_fan_speed   *speed;
        int                     num_speed;
};

Based on this informations the GPIO fan driver could perform the
speed conversions (pwm, rpm, GPIO value) and then provide a hwmon
interface.

Thanks for advice.

Simon

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky1nzcACgkQgtp0PDeOcDq7vACfWYIiuWJhfAw8Mlhslwx+3D1k
NS8AoIB8WCIaAZo3MTkpSbKwKVFy5j6t
=lFQf
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


--===============4857716558040823601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4857716558040823601==--
