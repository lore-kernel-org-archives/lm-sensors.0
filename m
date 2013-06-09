From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 09 Jun 2013 17:54:51 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.10-rc6
Message-Id: <20130609175451.GA13332@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6218246226512009107=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============6218246226512009107==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Linus,

Please pull hwmon fixes for Linux 3.10-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

This is not a critical patch, but one we'll want to have applied to -stable,
since the misdetection especially of LM84 has been causing trouble for quite
some time. I'll leave it up to you to decide if you want to pull or not.
If not, no problem, I'll resubmit during the next commit window.

Thanks,
Guenter
------

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 591bfcfc334a003ba31c0deff03b22e73349939b:

  hwmon: (adm1021) Strengthen chip detection for ADM1021, LM84 and MAX1617 (2013-06-07 12:29:31 -0700)

----------------------------------------------------------------
Improve chip detection in ADM1021 driver to avoid misdetections

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (adm1021) Strengthen chip detection for ADM1021, LM84 and MAX1617

 drivers/hwmon/adm1021.c |   58 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRtMFrAAoJEMsfJm/On5mBHBgP/R/FHADe+gu4zCG1iKVjSyrj
3IMt7Z0cINm55LfgHu+Au8yF7AcKlgIdEDuRFGO54+j8IYJq2NkWccXFsQfJ7DUs
JlpKjhN+29RGGGamG0z9hxYqcAyk3gTLIrz0amnBL84D21qpfkPKy/TE8d9mOjUQ
clzemgUvFlP8JsIW7ubDhzwF1LOZwmR/Xp/e0jKv2O/1+6m3AHMg9s4cHxKfltLW
72le5QyORbhSOg30mfmswWdas/Uon9TnzVHUBoWf0aoSoFufXgWvVZpoLFE6QHdx
ehGmxk0iChPqSej7yLLsFutC6K3TocYTf0GHv+87z1e8afN/h0bPfTKfTHUhGXdP
5oEOFeHNuLWJ4X+SeWqhjtVNSEpAMkubkNimH4onc2qpupa2SBLkkseDBfqAux1s
CZKZGhKHyMYm90cIVWsW+hqUKtKOfWk/3r5oz3K+fUcB03o7iXyWGxUXyRrJk8xF
mlCnOWwhx2sFs8cxxgoclEyVOJTT9qCnVcQ1iUfSCvaeNss++eyeXh8REBOFF9lt
nYujMnXCi9cndxAwHe4JGBUIwXksTKQq/0vRRM1+QL+9H/6W0JJqCM6y0jz+XsE2
i3nvM+53sKpSpbClmFjdsudXvgBs5G5mI1gg/be/UOiUH2l2rtEe3EAtg7a3tUN4
gg2MWG3rEA6p3G+Whp4n
=9d+d
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--


--===============6218246226512009107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6218246226512009107==--
