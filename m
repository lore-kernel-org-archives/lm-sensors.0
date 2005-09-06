From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Sep 2005 21:23:24 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: i2c-nforce2: drop unused define
Message-Id: <20050906212325.6ebeeac4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

One more cleanup in i2c-nforce2.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-nforce2.c |    5 -----
 1 files changed, 5 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/i2c/busses/i2c-nforce2.c	2005-07-27 19:08:48.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/busses/i2c-nforce2.c	2005-07-27 19:10:11.000000000 +0200
@@ -98,11 +98,6 @@
 #define NVIDIA_SMB_PRTCL_PEC			0x80
 
 
-/* Other settings */
-#define MAX_TIMEOUT 256
-
-
-
 static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
 		       unsigned short flags, char read_write,
 		       u8 command, int size, union i2c_smbus_data *data);


-- 
Jean Delvare
