From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 15 Mar 2012 15:36:24 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.3-rc8/final
Message-Id: <20120315153624.GA11981@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9209947468033749638=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============9209947468033749638==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.3-rc8/final from tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter

------

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

  Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Guenter Roeck (4):
      hwmon: (w83627ehf) Fix writing into fan_stop_time for NCT6775F/NCT6776F
      hwmon: (w83627ehf) Fix memory leak in probe function
      hwmon: (w83627ehf) Describe undocumented pwm attributes
      hwmon: (zl6100) Enable interval between chip accesses for all chips

Jean Delvare (1):
      hwmon: (w83627ehf) Fix temp2 source for W83627UHG

 Documentation/hwmon/w83627ehf |    9 +++++++--
 Documentation/hwmon/zl6100    |   14 ++++++--------
 drivers/hwmon/pmbus/zl6100.c  |   12 +++---------
 drivers/hwmon/w83627ehf.c     |   17 ++++++++---------
 4 files changed, 24 insertions(+), 28 deletions(-)

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYgx4AAoJEMsfJm/On5mBF/QP/joJny3gbI5fyB0hBF4eax2x
nKghdcAlMlAPXWOkQTbi+o4NuceWvRBI9OBhaYuYZdGv0DwBRpxsqbK7gXoRp852
kYsL48Rp7CXi190zoMyZaaCMatjuM//H/WVEarISpyknMymlD78Voqwaj9OVfhyJ
4H7DtVGR3qZLsqlUsEsM/eydi5i8CcgTjJczkkYL349DQSGo7PD2R1cAx20mGlt9
cgf0UaZnfSwUzNQqfVs7wR9rtQLO9EFvTvgdOAQSBIpcDM8v5yL5+wWZmQILa6IQ
Ob8VfNAbxw4Mm9Z9o3y24nG4CQPF+cbQoLGSlXhhKIfNSkXFE4gm6hVmriweh0Rz
vZLdjaFqjfoNk8l8bPeDJ49NYxU8DtGxWUetzau7Kbe0NawhCOwqiGEz2QeNvYq8
31FHHev/Qz2B/k3hUSIIKfa+63afgNkh58huiA08HqnQumDiyXHUeO1vV/EKuUnY
nOj8qVyxgwaPl9I44KZmRPIJQh5pUppgLoOTKSR1m6rwjiwVBIVvvhpFi5tJ0Moz
Zr/0DXahyQGgPpK8mRCha4JoMJ/BNzkrZOv39RsEdQsVq9xIGYpxhj6WSlU8PHuT
HbJpYmiOC5fa60I5EnCnjObOoNMX8yP6UodNSUTYWvyCfyCjNsknFtZAK4Da/bLi
z8FP7XIullegG62MNBa1
=1tiT
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


--===============9209947468033749638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9209947468033749638==--
