From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:37 +0000
Subject: [lm-sensors] [PATCH 11/44] [PATCH] I2C: i2c-piix4: Fix typo in
Message-Id: <11510009273507-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Fix i2c-piix4 documentation typo.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/i2c-piix4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
index 10957be..a706ae6 100644
--- a/Documentation/i2c/busses/i2c-piix4
+++ b/Documentation/i2c/busses/i2c-piix4
@@ -63,7 +63,7 @@ The PIIX4E is just an new version of the
 The PIIX/PIIX3 does not implement an SMBus or I2C bus, so you can't use
 this driver on those mainboards.
 
-The ServerWorks Southbridges, the Intel 440MX, and the Victory766 are
+The ServerWorks Southbridges, the Intel 440MX, and the Victory66 are
 identical to the PIIX4 in I2C/SMBus support.
 
 If you own Force CPCI735 motherboard or other OSB4 based systems you may need
-- 
1.4.0


