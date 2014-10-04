From: Mark Brown <broonie@kernel.org>
Date: Sat, 04 Oct 2014 09:53:49 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/4] hwmon: ltc2978: device tree bindings documentation
Message-Id: <20141004095349.GB4609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6023191983188679137=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com>
 <1412275071-6417-2-git-send-email-atull@opensource.altera.com>
 <20141003122736.GH26643@leverpostej>
 <542EDCDB.6040406@roeck-us.net>
 <20141003231334.GA4609@sirena.org.uk>
 <542F2FE3.60507@roeck-us.net>
In-Reply-To: <542F2FE3.60507@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "atull@opensource.altera.com" <atull@opensource.altera.com>, "jdelvare@suse.de" <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "delicious.quinoa@gmail.com" <delicious.quinoa@gmail.com>, "dinguyen@opensource.altera.com" <dinguyen@opensource.altera.com>, "yvanderv@opensource.altera.com" <yvanderv@opensource.altera.com>


--===============6023191983188679137==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 04:23:15PM -0700, Guenter Roeck wrote:
> On 10/03/2014 04:13 PM, Mark Brown wrote:

> >Nope, nothing to do with regulator that I'm aware of and I've not seen
> >any examples (but I don't tend to review users too often).

> Many examples, really. Just picking one.

> Documentation/devicetree/bindings/mfd/tps6507x.txt

OK, that's not an actual DTS...  I'm not seeing anything in the code.

> 	regulators {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 		...

> This also uses the reg property for the regulator index
> (without explaining it further). Seems to be pretty common.

If it's doing that it's nothing to do with the regulator API.

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUL8OsAAoJECTWi3JdVIfQl3QH/0XbMyh3/nBelRTyQ/tU2svk
p/F7bdWEU9Ffx96qOP6RjM78I/MmXPE8EdHOKi76V6ri1bhzTCPvzEEnSj34E/Ha
zQWQastXpG8D8I/0qjf2NMc19QkpfA8dM4dGPq+TCedZJPpwrikN2USB1/Myq2jW
cfZcTfolj8iemnjLlPacYTEGgGrh9mSdPbOj2UDFd6jXaHHo+DTCXOVxwpdC8UqB
gvpySGfbcQSxeUfaKvpBnu+sJh2zKvxWkb9XJNUY+yOaI7dyCbCDPfyugg56KRcq
Bxctz+XKALuiDT5DenerWQ08PNJA8pewCvMnt6PA/TfXufEm03Rj//cNB6IbS3Q=
=906O
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--


--===============6023191983188679137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6023191983188679137==--
