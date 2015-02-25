From: Simon Guinot <simon.guinot@sequanux.org>
Date: Wed, 25 Feb 2015 11:14:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <20150225111430.GV1509@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7458823317178377374=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
 <20150223143416.GT1509@kw.sim.vm.gnt> <54EB3C84.30503@roeck-us.net>
In-Reply-To: <54EB3C84.30503@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org


--===============7458823317178377374==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ri7MIv52hxsKkbzo"
Content-Disposition: inline


--ri7MIv52hxsKkbzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 06:43:16AM -0800, Guenter Roeck wrote:
> On 02/23/2015 06:34 AM, Simon Guinot wrote:
> >On Mon, Feb 23, 2015 at 06:06:12AM -0800, Guenter Roeck wrote:
> >>On 02/23/2015 04:58 AM, Simon Guinot wrote:
> >>>On some boards, such as the LaCie 2Big Network v2 or 2Big NAS (based on
> >>>Marvell Kirkwood SoCs), an I2C fan controller is used but the alarm
> >>>signal is wired to a separate GPIO. Unfortunately, the gpio-fan driver
> >>>can't be used to handle GPIO alarm alone from DT: an error is returned
> >>>if the "gpios" DT property is missing.
> >>>
> >>>This patch allows to use the gpio-fan driver even if the "alarm-gpios"
> >>>DT property is defined alone.
> >>>
> >>
> >>That is the wrong solution. The gpio alarm signal should be handled
> >>by the fan controller driver.
> >
> >Hi Guenter,
> >
> >Sure it should, but unfortunately it is not the case. I have several
> >boards using this mechanism (ie: a separate fan alarm GPIO). I think the
> >idea was to reduce the board cost...
> >
> Well, yes, the driver for the fan controller chip needs to be updated
> to support interrupts.

This will not help for the boards I mentioned. As an attempt to reduce
the board cost, a fan with 2 wires has been used. This means we don't
have any tachymeter feedback and then the controller alarm mechanism
can't be used. Instead a kind of hardware hack allows to have a fan
alarm on a separate GPIO.

>=20
> >Then this means I need a way to support this alarm signal and I can't
> >find a better one than using gpio-fan. Note that this was possible with
> >the original gpio-fan implementation (before the DT binding addition).
> >
>=20
> That doesn't help.

Handle the GPIO fan alarm feature from the fan controller driver don't
look good either to me. This alarm mechanism is not a part of the fan
controller itself but rather something apart. Also I am afraid that the
result would really look like a hack.

Simon

>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--ri7MIv52hxsKkbzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTtrpYACgkQgtp0PDeOcDr24gCePcuEMPS4jg6BIY76MUZSTd1S
wUUAnifyYpCxX/RhwYgg+/vIQ+6krGgS
=07eH
-----END PGP SIGNATURE-----

--ri7MIv52hxsKkbzo--


--===============7458823317178377374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7458823317178377374==--
