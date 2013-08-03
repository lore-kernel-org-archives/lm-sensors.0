From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 03 Aug 2013 14:23:26 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.11-rc4
Message-Id: <20130803142326.GA19561@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3979003014895059512=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============3979003014895059512==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.11-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter
------

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 5c52add19733eb36d8619713312f5604efef3502:

  hwmon: (max6697) fix MAX6581 ideality (2013-08-03 07:04:50 -0700)

----------------------------------------------------------------
Fix chip initialization/configuration in MAX6697 driver

----------------------------------------------------------------
Vivien Didelot (1):
      hwmon: (max6697) fix MAX6581 ideality

 drivers/hwmon/max6697.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR/RJeAAoJEMsfJm/On5mBnesP/Ay9sQW6RnBirfLlcCGkzTVx
hWXkRafJK0VtESwTRmzXY8VjI3chqgmzn2AWh8NkhxoHVl90cX1NZ2PLGj/YRqk2
8RW1LAZ4rDYxjwi8PCsYMUscPhKpogYnor6sc+xEiMlKX7P0QN8aUlZxZmu+J6k6
4kLIw6hpZ0sWAGp2hzFhgmaccLkAALJ/Upn10HBsAjE2cYHaqsx5Zh6VVY3ssURy
QUeQc2xPaBnjJM5eSpRSBrJwitXfPXpiWc6vbGkwSDkKxpVOHWzRdZthU4o1tau5
TQTJBj4Tt/VBqNLjk/NLSNQUPJ2KJtH3Qf8ie6Hp1D3tG6ySzm0y0/nU7RKJC3iI
XFwLO8ZLEFHN1Wc8hBWvjZDphqY27ep/GIV0aW1d0V8AWeXNvgBMmMEdruphZyzq
LLfWsr9RyXZ/4qnKyOq9muUDEJxHG59GK3229rdORLwszbJxj1qnmvc4q8wMlP0E
W6yaqAZnqeAfCn+U7yc7d8ZM84U0hYD28HNpfy3sFY8pOi4EllyqYITCAapZpmWU
ngALVQs42KRxm46/jKrxhBJvxW7nb7IaTjLwnCUEoeISHlr93GW+Ed3pTFzVo+PF
GjiYgSic/ni2xtMdf1uoMqGkTbKBAfbfFygS0FSLRAts7Cn5eCRpmWSn8ppEp7Nt
rCcXCyMpRkmPQyjZatPD
=gYQG
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


--===============3979003014895059512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3979003014895059512==--
