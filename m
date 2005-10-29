From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:18:59 +0000
Subject: [lm-sensors] [PATCH] i2c: i2c-i801 PEC code cleanups
Message-Id: <11305336642316@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: i2c-i801 PEC code cleanups

The tests leading to the use of hardware PEC in the i2c-i801 driver
can be simplified.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e8aac4a9b417643dd9739b48473790a09b8b6cbe
tree 70934ffa1a7327c62d13f09d0e1d8b74277b0a62
parent 585b3160f8212e58325bc1c0292c2ec01ac5db84
author Jean Delvare <khali@linux-fr.org> Wed, 26 Oct 2005 21:34:42 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:14 -0700

 drivers/i2c/busses/i2c-i801.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 27e7894..4f63195 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -388,7 +388,7 @@ static int i801_block_transaction(union 
 			goto END;
 	}
 
-	if (hwpec && command = I2C_SMBUS_BLOCK_DATA) {
+	if (hwpec) {
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
 		do {
@@ -416,12 +416,13 @@ static s32 i801_access(struct i2c_adapte
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
@@ -467,11 +468,9 @@ static s32 i801_access(struct i2c_adapte
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
@@ -479,11 +478,8 @@ static s32 i801_access(struct i2c_adapte
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

