From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [a.othieno@bluewin.ch: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c:
Message-Id: <20040417195011.GB1163@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Arthur Othieno <a.othieno@bluewin.ch> -----

To: frodol@dds.nl
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c: kill duplicate #include
From: Arthur Othieno <a.othieno@bluewin.ch>
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on morannon.frodo.local
X-Spam-Status: No, hits=0.1 required=5.0 tests=RCVD_IN_SORBS autolearn=no 
	version=2.63
X-Spam-Level: 

Hi,

From scripts/checkincludes.pl:

  ./drivers/i2c/busses/i2c-piix4.c: linux/config.h is included more than once.

Against 2.6.5. Thanks.


--- a/drivers/i2c/busses/i2c-piix4.c	2004-04-11 14:05:35.000000000 +0200
+++ b/drivers/i2c/busses/i2c-piix4.c	2004-04-16 17:52:16.000000000 +0200
@@ -31,7 +31,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
