From: bunk@stusta.de (Adrian Bunk)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [2.6 patch] i2c it87.c: remove an unused function
Message-Id: <20041028222039.GO3207@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Gauthron <chrisg@0-in.com>, greg@kroah.com, phil@netroedge.com
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from drivers/i2c/chips/it87.c


diffstat output:
 drivers/i2c/chips/it87.c |    7 -------
 1 files changed, 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/i2c/chips/it87.c.old	2004-10-28 23:00:26.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/i2c/chips/it87.c	2004-10-28 23:00:37.000000000 +0200
@@ -56,13 +56,6 @@
 #define PME	0x04	/* The device with the fan registers in it */
 #define	DEVID	0x20	/* Register: Device ID */
 
- -static inline void
- -superio_outb(int reg, int val)
- -{
- -	outb(reg, REG);
- -	outb(val, VAL);
- -}
- -
 static inline int
 superio_inb(int reg)
 {


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXC3mfzqmE8StAARAnheAJ4oIAZ/LT/MvhtbLjQpkCokdnkCzQCeMUx+
0hf83OAbIcIyj95pPV3hUWg=AgjG
-----END PGP SIGNATURE-----
