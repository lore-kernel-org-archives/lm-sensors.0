From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Jun 2012 14:03:20 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.5-rc4
Message-Id: <20120621140320.GA14213@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5295435567038926246=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============5295435567038926246==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.5-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter

------

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 2355375efdf10f43680d420023baa97796bfcdff:

  hwmon: (emc2103) Fix use of an uninitilized variable in error case (2012-06-18 08:48:00 -0700)

----------------------------------------------------------------
hwmon fixes for 3.5-rc4

Two minor fixes in emc2103 and applesmc drivers.

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (emc2103) Fix use of an uninitilized variable in error case

Henrik Rydberg (1):
      hwmon: (applesmc) Limit key length in warning messages

 drivers/hwmon/applesmc.c |    4 ++--
 drivers/hwmon/emc2103.c  |   12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJP4ymoAAoJEMsfJm/On5mBzOcP/25F+NtDkgUMwSKZ7Ov2bypE
HVdISkBzjtg7f13mP4dYv4K3oPwvIEo0T8yLiv4Giez3/uqBIgDTquJl2MJKQkVL
MHW05aBGS9ohOy/g6C/Zu/kX02mQc8j1ZAJsL8kl4GBT5AlsvNDaEeb0WDcoX+3A
fxwPgnMRCQHDzmp7EAGr1cTGUo0PMhLHIzNK+ezJzGJhUi9MKLsadEvHwdn9W8YO
Dw7hW5vcXH1dmIE/2tnVUsS/T7ddyQ/zNQzcK8vXTvgwjsazdad8oBuDSSpjuoxX
hmM2ekvFEDrShhTqxmlp5EFLheoHecxzG2E867Y3gywUDVy21M2D9ZGOg5TZ6xTP
+amWcFcwDifI+Vr0CBKE6oGnJ3RrvD5fjFwN+M3tg2cJs1RoC4kY60kdvhBUFH9d
gGRT9Oy5ffZSrwuWfrNqOM3yYsNFXvJSFjkeiQYGfPXNqT4AJyOdXQK0rfRuINny
g981UFC8vXexKYnjKT/ODEFcEpyKgJPBKtPqW03k/ONH0JRaDLLtE3L5AzjAIm2h
qZ9ioMJ6Ntf6kXWiqDW+RhCpuJTLfh4obh9kgjaDPAQkxCXsDz0AtvpKsFJ2ERLb
4mOXb8L7tD3tCa5oyP7ABEWz+iE//v6LTaRekBCbdMQwHTymTeN0KLFL/lWH/vKI
dt6aklGGc3O0Fc2h5bTi
=BOFw
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--


--===============5295435567038926246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5295435567038926246==--
