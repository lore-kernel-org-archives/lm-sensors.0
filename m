From: Simon Guinot <simon@sequanux.org>
Date: Wed, 20 Oct 2010 19:10:05 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <20101020191005.GL29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6977713296415731376=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
	<20101020165933.GC22572@ericsson.com>
In-Reply-To: <20101020165933.GC22572@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============6977713296415731376==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Content-Disposition: inline


--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 20, 2010 at 09:59:33AM -0700, Guenter Roeck wrote:
> On Wed, Oct 20, 2010 at 12:37:26PM -0400, Simon Guinot wrote:
> > This patch adds hwmon support for the GPIO connected fan.
> >=20
> > Platform specific informations as GPIO pinout and speed conversion array
> > (rpm from/to GPIO value) are passed to the driver via platform_data.
> >=20
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
>=20
> MicroSomething makes it really easy to be annoyed with them (folks, are y=
ou reading this ?).
> Mailer screwed up the patch again. We are making some noise to get this f=
ixed,
> but that will take a while - the affected mail servers are hiding somewhe=
re in Europe.
>=20
> Unfortunately, none of the hwmon and linux-arm archives I am aware of mak=
es
> patches available on the web (like patchwork does), so I can not get it f=
rom there
> either. Can you resend it to me as attachment, or give me a pointer where=
 I can
> pick it up ?

You could use:

ftp://lacie-nas.org/kernel/patches/0001-hwmon-add-generic-GPIO-fan-driver.p=
atch

and in a unknown and variable delay:

git://lacie-nas.org/lacie-orion.git (gpio-fan)

Simon

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky/Po0ACgkQgtp0PDeOcDpw9ACghCS0Ql9NQ0kl5RHjuZP6P18e
BpgAmgMXn5ECdzJbSmdYyKpjK7eVcdde
=j4L9
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--


--===============6977713296415731376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6977713296415731376==--
