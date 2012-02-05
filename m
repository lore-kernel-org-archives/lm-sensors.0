From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 05 Feb 2012 06:22:06 +0000
Subject: [lm-sensors] [GIT PULL] hwmon subsystem fixes for 3.3-rc3
Message-Id: <20120205062206.GA1853@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9187757180954329198=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============9187757180954329198==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.3-rc3 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Signed tag: hwmon-fixes-for-3.3-rc3

Just a single patch this time.

Since this is the first time I tried using a signed tag, I provided both a
branch and a signed tag to pull from. If the tag works, I'll only provide
the tag next time. If something is wrong with the tag, please let me know.

Thanks,
Guenter

------

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Guenter Roeck (1):
      hwmon: (w83627ehf) Fix number of fans for NCT6776F

 drivers/hwmon/w83627ehf.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPLiAOAAoJEMsfJm/On5mBMJMP/jYxW9uiSyXWBds8uZxlr1P2
cadf9hGz2N6paRGNxGDk+Wk+FhlaIbFnrMB6YjTWBttB2oFSaiiU9xM888r3vQPH
Dge957qmO4zZLfruGw9YpAWSezXtqVoEtoStzw0fMYxH+Q0LMI/DgRi3rG+0Yjrr
i7zWJu2BVf/FJlxFmkKABUVlwBmcImraGXDLvoc9KDak3U3zoUE7s/ep7pwDC0Dq
DC0FZ/SPZ9lKPw65M42rM430JrGcfbXwNk6xK76ervYrkJm+6wxuR8WzHleLYlvJ
IiFWezmFlbuHwqDzkqOgGXVJoIZ5HxHRY9E95BJBcaLRZF39e4F7SHUgrvb2cEps
hld4sQb6SlHE7/uPJlrTlV5QgYQSWlHxNs1izknMcRIHiaof+d5DyjK2zAOxaCnO
F2FZi0FlnMlyPugieKxCUSe4BcbvPwBmSl7byYdWhUuYwsJBzkCyKGMYbfFzE+RS
b2ndrSl6AJRFHAW3Eb/ygmp66m6cjIe3lnh3iNbyKWNc77DuHTp/SoKJNGuPYsrh
mcPHfGL5krl+7zBbCJpM+bjMB2cuBFuEW8Uy33XDc8yBbzMkilBbq50a4KNVBOeD
ysCdnw7ilPReUsaEV0645GLPF5Ax6yDkc7ayeU6oj7uDIM2s73zWFMgqfvg8sv11
XOzsOrKhSvVaUD6GhB69
=RYmJ
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--


--===============9187757180954329198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9187757180954329198==--
