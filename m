From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 03 May 2012 18:00:12 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.4-rc6
Message-Id: <20120503180012.GA15983@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6269729053465740625=="
List-Id: <lm-sensors.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============6269729053465740625==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull hwmon fixes for Linux 3.4-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter

------

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

for you to fetch changes up to bdc71c9a87b898e4c380c23b2e3e18071312ecde:

  hwmon: (coretemp) Increase CPU core limit (2012-05-01 09:16:14 -0700)

----------------------------------------------------------------
hwmon fixes for 3.4-rc6

Fix OOPS seen in coretemp driver if the CPU core ID is too large

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (coretemp) Increase CPU core limit

Kirill A. Shutemov (1):
      hwmon: (coretemp) fix oops on cpu unplug

 drivers/hwmon/coretemp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPoserAAoJEMsfJm/On5mBBcgP/jS39FBXx/XsHYmWrTpL/u7k
SyDzlkYnn04709+fWjF72NH7TOzJxRtVtM7BcVtpoibFDXIJI7DRUEsekMNLLZyz
dmT8D4Ju3MBbXxQT+hSNhDeype62VFoVAVsIMKD5urylulQYf7X0QJPEh+TYSmaQ
QLVbVV4d4wLgPtMPnTUyYTOMNpxcLAeydZRjq9T1UB0Sk+fgpUVYsjlZzrZGHFTp
MmTiLB+7xjGOCqBMDlzEQ+H7HrXxnpUUwvwluDiAiw6F6xJSsE++Zm2llECywWDq
BrBG066HFzy41FDqYS9x4cslH/k4wLKuVD43ytwkvLAHyIEZUEY7Ai2sGM7WQYws
eRbcg1iH/rrb3z2DVitAsxF98WTXzhDsrUKviyAnQKrsoghacEpbG3oeWjgHRgt2
0FxCUGoBIsoejzgO+Y4tXY5OUEc7GJ+dCrlITtuQg1GAsFHtY/120itU7Fhl6krf
NVPYYIVYlDCB+CXDKeRWrExl6Yv85aLRvlNsYcdsAq9ScrkxE/1CEeopW5gcMW/S
sS8glCOVMO4fPP8GM846wIwHOAtOhQY51NCd1THT9cAKeGIpgSirhTWWmTHm0Ogk
3e142EyFBWPUJvdE/YgcbBrBvk82sJH597BTBtYYZwkTal6h1tGWbHiapkr+iDv0
uPMJJ1MYrkQdp10R35pj
=pEKb
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


--===============6269729053465740625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6269729053465740625==--
