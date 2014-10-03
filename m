From: Mark Brown <broonie@kernel.org>
Date: Fri, 03 Oct 2014 16:42:06 +0000
Subject: Re: [lm-sensors] [PATCH v5 3/4] pmbus: add regulator support
Message-Id: <20141003164206.GD3594@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7881119742118408180=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com>
 <1412275071-6417-4-git-send-email-atull@opensource.altera.com>
 <20141003142746.GA24441@sirena.org.uk>
 <542EBF56.1000500@roeck-us.net>
In-Reply-To: <542EBF56.1000500@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: atull@opensource.altera.com, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com


--===============7881119742118408180==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 08:23:02AM -0700, Guenter Roeck wrote:

> do you have an immutable branch or tag I could merge to get
> the necessary regulator patches ?

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-simple-of

for you to fetch changes up to ef126a4a8112998a9d4dcea166781331f1020f76:

  regulator: of: Add stub OF match function for !OF case (2014-09-10 16:40:07 +0100)

----------------------------------------------------------------
regulator: Simplified OF matching

Provide a simplified way of matching regulators in DT in order to save
some fiddly code in drivers.

----------------------------------------------------------------
Mark Brown (2):
      regulator: of: Provide simplified DT parsing method
      regulator: of: Add stub OF match function for !OF case

 drivers/regulator/core.c         | 10 +++++---
 drivers/regulator/internal.h     | 14 +++++++++++
 drivers/regulator/of_regulator.c | 51 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  4 ++++
 4 files changed, 76 insertions(+), 3 deletions(-)

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULtHeAAoJECTWi3JdVIfQsCwH/3eBNoYsT6dWvay/mUbX5u0K
tALmzkghlLPIrdCtus6jKLTwRhGG+vMdWPZbmKN6ydsxswmIwHmIL/QoQow9jvZs
H455o+nbFLqk3hl9RdHzK1Y7v9oiz0PWVE84vK1+22i/UVeJGVZc8JLBMhN22PlP
UIz8dj83JTEZDSbfzgTh+rtOD2+g+TuYQYYoRoX5Kh7J0IKfNRH2l9902way+mWG
5Ke6AoCKWQDh4niRXnRrsHWDPRaZmHh0lncmmHYfSGXfoMZTEMisW7jPwcSEslHV
dfNy4vwcvkFMFmGqwqYsiPez43z0IG8UDBino9fWK1J1Rm9D/jLfLvw17d3Y08A=
=PWOq
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--


--===============7881119742118408180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7881119742118408180==--
