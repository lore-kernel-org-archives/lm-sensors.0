From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 26 Sep 2011 15:11:38 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.1
Message-Id: <1317049898.3888.53.camel@groeck-laptop>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7331141428862123786=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1315325608-17922-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1315325608-17922-1-git-send-email-guenter.roeck@ericsson.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============7331141428862123786==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-XHL6YmKMEo7cPPG8p5xy"

--=-XHL6YmKMEo7cPPG8p5xy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.1 from:

    git://github.com/groeck/linux.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit
d93dc5c4478c1fd5de85a3e8aece9aad7bbae044:

  Linux 3.1-rc7 (2011-09-21 16:58:15 -0700)

are available in the git repository at:
  git://github.com/groeck/linux.git hwmon-for-linus

Chris Peterson (1):
      hwmon: (w83791d) rename prototype parameter from 'register' to
'reg'

Guenter Roeck (1):
      hwmon: (coretemp) Don't use threshold registers for tempX_max

Jan Beulich (3):
      hwmon: (coretemp) don't use kernel assigned CPU number as platform
device ID
      hwmon: (coretemp) constify static data
      hwmon: (coretemp) remove struct platform_data * parameter from
create_core_data()

Jean Delvare (2):
      hwmon: (coretemp) Drop duplicate function get_pkg_tjmax
      hwmon: (coretemp) Let the user force TjMax

Roland Stigge (1):
      hwmon: (ds620) Fix handling of negative temperatures

 Documentation/hwmon/coretemp |   14 +--
 drivers/hwmon/coretemp.c     |  193
+++++++++---------------------------------
 drivers/hwmon/ds620.c        |    2 +-
 drivers/hwmon/w83791d.c      |    4 +-
 4 files changed, 47 insertions(+), 166 deletions(-)


--=-XHL6YmKMEo7cPPG8p5xy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOgJYnAAoJEANmWzN1g3l3fPQH/R3i6Fe+h9KQFvmwOvSMean7
q9TW4GEYh9dafxY1+voUR1sr9U1Jq4h3rgL34CZqTU/UOyUBHyFhGUfywPmjVROj
/0hFPnDRZOmGlAh4boX0OOnlmlbyni3pcx7rJCi0aNMuXs7hRfV2gOXtdrCfkOKW
UHZuMF3k3lcTdYXk1vWDCVRsTUvR2DXJzxwHDNNquVL/StHrcq325+ktQNT9H6Zm
FLtGdcWJKsNkg6oiFaw6ETNKclTSa0H6T9BbvjyjRgSOmp6ghKc++1hFi0GPbZsi
c1zoYLENCTFmO5fJXHa/4YmTJ6Ujq5Ts4fOwB5Ldp6WgOVkoJkwm3NdWuAdg7eU=
=726f
-----END PGP SIGNATURE-----

--=-XHL6YmKMEo7cPPG8p5xy--


--===============7331141428862123786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7331141428862123786==--
