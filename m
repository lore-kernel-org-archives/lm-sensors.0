From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Mon, 25 Nov 2013 15:40:33 +0000
Subject: Re: [lm-sensors] [PATCHv9 02/20] thermal: introduce device tree parser
Message-Id: <52936F71.8070806@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0402592536534023370=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1574695.YAEZXuUskK@amdc1227> <528E2B38.5050502@ti.com> <5333248.b0sPp1ZZXY@amdc1227> <528F4F1E.60903@ti.com> <20131125153118.GG32081@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131125153118.GG32081@e106331-lin.cambridge.arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Tomasz Figa <t.figa@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Pawel Moll <Pawel.Moll@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "wni@nvidia.com" <wni@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--===============0402592536534023370==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6x9oXx7jk9GCV8H5rRxSTsth7PCkp6NDU"

--6x9oXx7jk9GCV8H5rRxSTsth7PCkp6NDU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25-11-2013 11:31, Mark Rutland wrote:
> Any cooling device has a range of cooling states (i.e. different levels=

> of heat dissipation). For example a fan's cooling states correspond to
> the different fan speeds possible. Cooling states are referred to by
> single unsigned integers, where larger numbers mean greate heat
> dissipation. The precise set of cooling states associated with a device=

> (as referred to be the cooling-min-state and cooling-max-state
> properties) should be defined in a particular device's binding.

OK. Added this to the binding document.


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--6x9oXx7jk9GCV8H5rRxSTsth7PCkp6NDU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKTb3EACgkQCXcVR3XQvP37HgEAjrZfxK+sUCNEy0AuW2snm35B
FKWMpFFWgmf7QmwojokA+gMWMa5ZKnM1Hz4ENxSRyEWrWHTbppY1g/nNBIt0xVio
=ruHP
-----END PGP SIGNATURE-----

--6x9oXx7jk9GCV8H5rRxSTsth7PCkp6NDU--


--===============0402592536534023370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0402592536534023370==--
