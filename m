From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 09 Aug 2013 19:51:48 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.11-rc5
Message-Id: <20130809195148.GA11310@roeck-us.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7628335952262706128=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============7628335952262706128==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.11-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter
------

The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

  Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 93d783bcca69bfacc8dc739d8a050498402587b5:

  hwmon: (adt7470) Fix incorrect return code check (2013-08-08 12:43:07 -0700)

----------------------------------------------------------------
Fix bug in adt7470 driver which causes it to fail writing fan speed limits.

----------------------------------------------------------------
Curt Brune (1):
      hwmon: (adt7470) Fix incorrect return code check

 drivers/hwmon/adt7470.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSBUhUAAoJEMsfJm/On5mBJfAP/ja7+vKKKXrN1A7hVXUthVnG
GmXjTv0G3WNQRhzJ4NhPl16TOF9i3nY1uWlDPFxphqsmLngZB20Gg+wKzlBIlvlI
zMX0GRZHMO+9gePm9GPcw9ieD7teWY6qJB0ovvqrxWO2MLmFqjD/91WEFqinH0WD
0QbnQFlF9vhc7INo+tS3iyjvd0O3G9bT1YldyIUzGveWbsHvTOU8L+nxKnQdJuHl
roK14ezsDSCAlKOrbl7CGVVPOgoaSRYX+O47cBzHig7ZGr7LDKRyl4+fBeaP7+PE
0yUUyxDnUQ4zlKd7CpX4ldWjDvb0BNtjouR/96FC58f20hpuP+thnO9NqM9g+//C
slXpLdxWZaDHLqP76pxxj7tes8e8TLEP/VeNdnjxadqoJp+S16kslJmwtQpoSUJ2
iBhoGFYTqOREqsMvesmtQ+zGeC8fblARg2enrv3njHxgg0YIFt4M3ZldeLj8M6NN
DpTym2wyg9Z5l9ruB8thkAIQ0ite2krS72eBsgryRGbzunrEuf1H+DwSvMyRk/tt
xgcat2CpEk1dSbXQk8bGX4Pk3eBT4tU4p6OxzIjBWpptJC3np5uelGkiAOQIyjuY
4AnVrwNYwPdXS6fhuYoTegRO5ld2QGmujbS3Swivg31a/HhS6sxLNFG2NQjNbaHy
bTrCOEbK779L7YROnaKJ
=Ruri
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


--===============7628335952262706128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7628335952262706128==--
