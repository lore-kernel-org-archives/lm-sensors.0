From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Apr 2006 11:29:26 +0000
Subject: [lm-sensors] [PATCH 03/10] i2c-piix4: Fix typo in documentation
Message-Id: <20060425132926.538d84ed.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-piix4-fix-typo-in-documentation.patch

Fix i2c-piix4 documentation typo.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/i2c-piix4 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-git.orig/Documentation/i2c/busses/i2c-piix4	2006-04-02 23:16:24.000000000 +0200
+++ linux-2.6.16-git/Documentation/i2c/busses/i2c-piix4	2006-04-02 23:16:35.000000000 +0200
@@ -63,7 +63,7 @@
 The PIIX/PIIX3 does not implement an SMBus or I2C bus, so you can't use
 this driver on those mainboards.
 
-The ServerWorks Southbridges, the Intel 440MX, and the Victory766 are
+The ServerWorks Southbridges, the Intel 440MX, and the Victory66 are
 identical to the PIIX4 in I2C/SMBus support.
 
 If you own Force CPCI735 motherboard or other OSB4 based systems you may need

-- 
Jean Delvare

