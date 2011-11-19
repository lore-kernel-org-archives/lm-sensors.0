From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Nov 2011 12:08:28 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.2
Message-Id: <20111119120828.GA18100@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2685833683758605090=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20111106203942.1829bf78@endymion.delvare>
In-Reply-To: <20111106203942.1829bf78@endymion.delvare>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============2685833683758605090==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.2 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter

------

The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:

  Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Donggeun Kim (1):
      hwmon: (exynos4_tmu) Fix Kconfig dependency

 drivers/hwmon/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOx5w8AAoJEMsfJm/On5mBnmgP/08VlS1uYhARd3U1vjgQZoUo
5gsSJqbCtIMmuYB0O5uz5iLFxcB3gX/sCFe88juM+xbdEF4XJNm9pye7qo+riUli
Pc1kgtoZcGONRvUTZzzx3HpIhu5K7NiqIZco4/qLOxPVS0j6qRTPcJQ4sT9yJpaN
3Vaw70yO8dF3UqAnXqi+vVDDEmh3jvHJtPA0T2CNeAVrar/NfNm+UVd5ZoGuHKgJ
pfBRFCIYGrURbpTD69DI1Kl9b6aVLU7SIdzm2aUH893Woxv1jInN4QAqOcDSk9tP
sRv4d3w341O5SCYONf16txquqbsFfQDOsnGZKq/nfMAyuso1ZjE0E/UF+2e7OyEl
L8BIOmuxPIsEklZI8D2+Ia4y2MSCcePsCsNp1+C6OrrdvZ+xlaAOaaDVec84XTAN
mKSg8waRD5ixnXKhvmgv5aIkvQSV1PT+DZXlbt0o9ytFI86p6P3CJ3h0K9sYPCTX
j8V0k1FBhp/XAc+Ak23iSpL3CcHoQYGmRI3wi7AiJl9MaZ60T4dE+aha0ahBaYmV
N7SuvFonHXzbgP9xTVxM/QwXRyAp+Kr1Vxns2Sdc1oXIUrQ0dX58a9+FzVZ8yVf8
STqIn9unWj3jNvx5nV+xy3bPDiOkgJvIpPyVkFSnGbKFU/pCD277EWTT0DONrnxF
NQfKuBgw4jAIJqOaosjQ
=OIMV
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--


--===============2685833683758605090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2685833683758605090==--
