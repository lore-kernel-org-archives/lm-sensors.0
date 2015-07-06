From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Mon, 06 Jul 2015 19:07:49 +0000
Subject: Re: [lm-sensors] [PATCH] thermal: consistently use int for temperatures
Message-Id: <14808775.AMIXvBTC8g@diego>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org

Am Montag, 6. Juli 2015, 09:19:49 schrieb Sascha Hauer:
> The thermal code uses int, long and unsigned long for temperatures
> in different places.
>=20
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0=B0C. This will probab=
ly
> immediately shut the machine down due to overtemperature if started below
> 0=B0C.
>=20
> 'long' is 64bit on several architectures. This is not needed since INT_MAX
> =B0mC is above the melting point of all known materials.
>=20
> Consistently use a plain 'int' for temperatures throughout the thermal co=
de
> and the drivers. This only changes the places in the drivers where the
> temperature is passed around as pointer, when drivers internally use
> another type this is not changed.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Peter Feuerer <peter@piie.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: lm-sensors@lm-sensors.org
> ---

For

>  drivers/thermal/rockchip_thermal.c                 | 10 ++++----

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
