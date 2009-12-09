From: Forest Bond <forest@alittletooquiet.net>
Date: Wed, 09 Dec 2009 16:23:01 +0000
Subject: Re: [lm-sensors] sensors-detect: probing i2c sensors racy?
Message-Id: <20091209162301.GC3947@alittletooquiet.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3390442346528590548=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20091209153225.GA3947@alittletooquiet.net>
In-Reply-To: <20091209153225.GA3947@alittletooquiet.net>
To: lm-sensors@vger.kernel.org


--===============3390442346528590548==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the quick reply.

On Wed, Dec 09, 2009 at 05:11:48PM +0100, Jean Delvare wrote:
> On Wed, 9 Dec 2009 10:32:25 -0500, Forest Bond wrote:
> > I am seeing a situation where sensors-detect fails to find sensors in a=
 single
> > run due to an apparent race condition.  It looks like it loads the i2c-=
* modules
> > and then tries to open /dev/i2c-0 for probing, but it fails to open
> > successfully.  My sense is that the device is not fully initialize and =
ready for
> > opening immediately following the modprobe calls, but sensors-detect do=
es not
> > wait for initialization to complete.  I'm not sure what should be happe=
ning.  It
> > seems sensible that modprobe would not return until the device is initi=
alized.
> >=20
> > Running sensors-detect again correctly probes the hardware because the =
i2c bus
> > is fully initialized at that point.
>=20
> You must be typing very fast to be able to trigger this ;) Or udev is
> very slow populating /dev on your machine.

You got me ;).

I'm doing this:

  yes '' | sensors-detect 2>&1 | tee sensors-detect.log

> > I don't know anything about i2c, so I hope the language I'm using to de=
scribe
> > this situation is reasonable.
>=20
> It is perfect.
>=20
> > I've attached the output from sensors-detect for the first (failed) run=
 and the
> > second (successful) run.
> >=20
> > Thoughts?
>=20
> The version of the sensors-detect you're using is getting old. Please
> give a try to the latest one:
> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>=20
> If you can still reproduce the problem, then please give a try to the
> attached patch and report.

Okay, I'll give this a try.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFLH87lRO4fQQdv5AwRAm33AJ9jAQoxKvv3gGRawYFqOsGsau5i3gCfYqyP
kI1P+sMVD7sZSlhdJsb2NSg=
=5gFg
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--


--===============3390442346528590548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3390442346528590548==--
