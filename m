From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:33:58 +0000
Subject: [lm-sensors] [PATCH 12/16] i2c: i2c-i801 PEC code cleanups
Message-Id: <20051026213442.30f013ec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-i801-simplify-hwpec-tests.patch

The tests leading to the use of hardware PEC in the i2c-i801 driver
can be simplified.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-i801.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- linux-2.6.14-rc5.orig/drivers/i2c/busses/i2c-i801.c	2005-10-23 13:35:11.000000000 +0200
+++ linux-2.6.14-rc5/drivers/i2c/busses/i2c-i801.c	2005-10-23 13:50:37.000000000 +0200
@@ -388,7 +388,7 @@
 			goto END;
 	}
 
-	if (hwpec && command = I2C_SMBUS_BLOCK_DATA) {
+	if (hwpec) {
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
 		do {
@@ -416,12 +416,13 @@
 		       unsigned short flags, char read_write, u8 command,
 		       int size, union i2c_smbus_data * data)
 {
-	int hwpec = 0;
+	int hwpec;
 	int block = 0;
 	int ret, xact = 0;
 
-	if(isich4)
-		hwpec = (flags & I2C_CLIENT_PEC) != 0;
+	hwpec = isich4 && (flags & I2C_CLIENT_PEC)
+		&& size != I2C_SMBUS_QUICK
+		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
@@ -467,11 +468,9 @@
 		return -1;
 	}
 
-	if(isich4 && hwpec) {
-		if(size != I2C_SMBUS_QUICK &&
-		   size != I2C_SMBUS_I2C_BLOCK_DATA)
-			outb_p(1, SMBAUXCTL);	/* enable HW PEC */
-	}
+	if (hwpec)
+		outb_p(1, SMBAUXCTL);	/* enable hardware PEC */
+
 	if(block)
 		ret = i801_block_transaction(data, read_write, size, hwpec);
 	else {
@@ -479,11 +478,8 @@
 		ret = i801_transaction();
 	}
 
-	if(isich4 && hwpec) {
-		if(size != I2C_SMBUS_QUICK &&
-		   size != I2C_SMBUS_I2C_BLOCK_DATA)
-			outb_p(0, SMBAUXCTL);
-	}
+	if (hwpec)
+		outb_p(0, SMBAUXCTL);	/* disable hardware PEC */
 
 	if(block)
 		return ret;

-- 
Jean Delvare
