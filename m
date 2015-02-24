From: Eduardo Valentin <edubezval@gmail.com>
Date: Tue, 24 Feb 2015 19:57:51 +0000
Subject: Re: [lm-sensors] [PATCH V2] (gpio-fan): Add thermal control hooks
Message-Id: <20150224195749.GA559@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4547423638388856484=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1420740303-12529-1-git-send-email-nm@ti.com>
 <54AF5DA8.6080408@roeck-us.net>
 <20150224192933.GJ3448@developer.amazonguestwifi.org>
 <20150224195457.GA16245@roeck-us.net>
In-Reply-To: <20150224195457.GA16245@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nishanth Menon <nm@ti.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--===============4547423638388856484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 11:55:23AM -0800, Guenter Roeck wrote:
> On Tue, Feb 24, 2015 at 03:29:35PM -0400, Eduardo Valentin wrote:
> > Guenter,
> >=20
> > On Thu, Jan 08, 2015 at 08:48:40PM -0800, Guenter Roeck wrote:
> > > On 01/08/2015 10:05 AM, Nishanth Menon wrote:
> > > > Allow gpio-fan to be used as thermal cooling device for platforms t=
hat
> > > > use GPIO maps to control fans.
> > > >
> > > > As part of this change, we make the shutdown and remove logic the s=
ame
> > > > as well.
> > > >
> > > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > > ---
> > >=20
> > > Applied to -next.
> >=20
> > What is the target kernel version for this change? It didn't make
> > 4.0-rc1
> >=20
> If I recall correctly, I had to pull it because the thermal framework
> does not provide hooks if disabled. Weird, I am sure I sent an e-mail
> about this, but I don't find it right now.
>=20
> It can't make it in before the hooks are in place, or we'll need
> another version with ifdefs around the thermal registration code.

Got it!

I applied the fix that Nishanth sent to thermal.h [1]. I am planing to
send it during 4.0 rc cycles.

Thanks for the clarification.

[1] -
https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git=
/commit/?h=3Dfixes&id=3D12ca7188468ee29c4e717f73db4bf43c90954fc7

>=20
> Guenter

Eduardo Valentin

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7Ne0AAoJEMLUO4d9pOJWJnQH/0WUAOjQx1rk1KFeZMsrijg3
qPVs2Em24CtP1EG2styUg+k7rNlsAoyMWsUMJiv4EW6yPYL+p9jemW8PO5elC9Bw
IfR7H8QrES68NfNn4XfUPEtVeaHFWfZX8rgMwW9UJOPh8tIGEpzkyeaIqOCEMb6W
rA7DkmkQLUaBTm1FuIEbGG+lw0piy7Rx8Ba76dA3IPztDsFpZYDrnC/bvtt4Zy/P
wrVi/POITAeA++WvBJ34d284saJM29yz4V2t2o2JsXRU+Go/XcpPWAm+KSYaE0BV
WlcXUSZYTwCPkmhSXRkOQcy5TAVhw/jn0KAI6bU+PITTcc3P7cquOGukZamAZHo=
=p7TH
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


--===============4547423638388856484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4547423638388856484==--
