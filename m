From: Forest Bond <forest@alittletooquiet.net>
Date: Wed, 09 Dec 2009 15:56:25 +0000
Subject: Re: [lm-sensors] sensors-detect: probing i2c sensors racy?
Message-Id: <20091209155625.GB3947@alittletooquiet.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5957927394077516829=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20091209153225.GA3947@alittletooquiet.net>
In-Reply-To: <20091209153225.GA3947@alittletooquiet.net>
To: lm-sensors@vger.kernel.org


--===============5957927394077516829==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 09, 2009 at 10:32:25AM -0500, Forest Bond wrote:
> I am seeing a situation where sensors-detect fails to find sensors in a s=
ingle
> run due to an apparent race condition.  It looks like it loads the i2c-* =
modules
> and then tries to open /dev/i2c-0 for probing, but it fails to open
> successfully.  My sense is that the device is not fully initialize and re=
ady for
> opening immediately following the modprobe calls, but sensors-detect does=
 not
> wait for initialization to complete.  I'm not sure what should be happeni=
ng.  It
> seems sensible that modprobe would not return until the device is initial=
ized.
>=20
> Running sensors-detect again correctly probes the hardware because the i2=
c bus
> is fully initialized at that point.
>=20
> I don't know anything about i2c, so I hope the language I'm using to desc=
ribe
> this situation is reasonable.
>=20
> I've attached the output from sensors-detect for the first (failed) run a=
nd the
> second (successful) run.

FWIW, this issue is also affecting the same hardware:

https://bugs.launchpad.net/ubuntu/+source/lm-sensors-3/+bug/458811

sensors-detect issue was noted while testing with acpi=3Doff to avoid the r=
esource
conflict.  Maybe the two issues are related.

-Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFLH8ipRO4fQQdv5AwRAhftAJ91gijz9VJgDAi1EzybISFgzaV3LQCcCNnu
TTLZwXA7rAIQpNN76M9FxNg=
=9E7O
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--


--===============5957927394077516829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5957927394077516829==--
