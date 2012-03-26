From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 26 Mar 2012 10:37:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: max6639: Fix CONFIG_PM compile option
Message-Id: <20120326103711.GE3098@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6313373569140313138=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1332614169-30854-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1332614169-30854-1-git-send-email-stigge@antcom.de>
To: lm-sensors@vger.kernel.org


--===============6313373569140313138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 24, 2012 at 03:52:38PM -0700, Guenter Roeck wrote:
> On Sat, Mar 24, 2012 at 03:45:43PM -0400, Roland Stigge wrote:

> > >> +#ifdef CONFIG_PM

> > > Looking into other drivers, I think that should be CONFIG_PM_SLEEP

> > Which other drivers did you mean?

> > What about those drivers that all handle it via CONFIG_PM:

> > abituguru.c
> > abituguru3.c
> > exynos4_tmu.c
> > gpio-fan.c
> > jc42.c
> > lm75.c
> > tmp102.c

> Those drivers don't use SET_SYSTEM_SLEEP_PM_OPS. I checked several drivers
> which do use SET_SYSTEM_SLEEP_PM_OPS, and they all use CONFIG_PM_SLEEP.

It's nothing to do with SET_SYSTEM_SLEEP_PM_OPS - it's more about
drivers that are following current best practice (which includes using
the SET_ macros).  A modern driver should be using CONFIG_PM_SLEEP for
system sleep operations and CONFIG_PM_RUNTIME for runtime PM operations
since they can be enabled independently.  CONFIG_PM should only control
having dev_pm_ops at all (if you want to bother with the ifdefery).

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcEbQAAoJEBus8iNuMP3deKEP/2VWEa+G3Vbic1otO1X7Nilv
9FFWfgCgkruRtvQpXjDfvtGOFRXGYvFee1804J+QGMNnVvmFRtRuZrbNkLV7zZaO
yVeKxYKb+iHdibK+RVGtwyK/OpcFcEUxkDBWGd8S/cElGP/MtwODKeTBh5ok+R6j
v71CdAXlTWeAwGM33zVEAfxOzcGFBcOzqsaBxeyK0AECEkFvyMFM1F5H8sAyee4n
8Dw2BDZ5KiXoycFVwh2Pwz5G+HgAacZ7DA6Ud/x4yYyHolAcC4ETAUvXoIo5DPUh
IX+LAt+lmDtEpYf3xjYLqdyG1NgisX1ArP3rqnXAJwePThyYkrrBF7bjFC1BcVxL
LYYwdpS9dlENievVCj7gMwL2EzfDhcEpXQZj4doZPDAzG4APNoP9usR8WSk8oJMu
/t8EAGd2TaI+AVTtbClevUX8bXcfMtj3eEGqQkrp7sH5FkaNBUEcvHVx8sx2GkO4
gCxijP65wwG258UB76QAIT/YeBz33SXMKl7TcaR2kXWOVtshzuvhZKSuJmSq+P73
pH0Gbelbw9W42Kkj8Pv28XZitn14ZD9tRmkBhzKfUQcKtNLVsxugtuS3Jj8A7EBj
BQeU5JPIy0niUXtRX/RU42gtX1cT0WkKDe3+Ulwwv+VSzYt9JB/fnbyoKsePl8nj
DTupa1lcpDhXvWVTz8ec
=LimI
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--


--===============6313373569140313138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6313373569140313138==--
