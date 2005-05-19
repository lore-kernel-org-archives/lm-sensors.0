From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:18 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734191753@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734181829@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1217.7.2, 2003/09/12 16:58:01-07:00, greg@kroah.com

[PATCH] I2C: remove some usages of i2c_adapter.id as they are not used.

Seems i2c_adapter.id is only used in some video drivers, will work on
cleaning up that mess later...


 drivers/i2c/busses/i2c-ali1535.c |    1 -
 drivers/i2c/busses/i2c-ali15x3.c |    1 -
 drivers/i2c/busses/i2c-amd756.c  |    1 -
 drivers/i2c/busses/i2c-amd8111.c |    1 -
 drivers/i2c/busses/i2c-i801.c    |    1 -
 drivers/i2c/busses/i2c-isa.c     |    1 -
 drivers/i2c/busses/i2c-nforce2.c |    1 -
 drivers/i2c/busses/i2c-piix4.c   |    1 -
 drivers/i2c/busses/i2c-sis96x.c  |    1 -
 drivers/i2c/busses/i2c-viapro.c  |    1 -
 drivers/i2c/i2c-core.c           |    6 ++----
 11 files changed, 2 insertions(+), 14 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Sep 22 16:16:09 2003
@@ -481,7 +481,6 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI1535,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Mon Sep 22 16:16:09 2003
@@ -471,7 +471,6 @@
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI15X3,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Mon Sep 22 16:16:09 2003
@@ -304,7 +304,6 @@
 
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Mon Sep 22 16:16:09 2003
@@ -358,7 +358,6 @@
 	smbus->adapter.owner = THIS_MODULE;
 	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
-	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
 	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Sep 22 16:16:09 2003
@@ -540,7 +540,6 @@
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-isa.c	Mon Sep 22 16:16:09 2003
@@ -42,7 +42,6 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-nforce2.c	Mon Sep 22 16:16:09 2003
@@ -118,7 +118,6 @@
 
 static struct i2c_adapter nforce2_adapter = {
 	.owner          = THIS_MODULE,
-	.id             = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2,
 	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo           = &smbus_algorithm,
 	.name   	= "unset",
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Sep 22 16:16:09 2003
@@ -395,7 +395,6 @@
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_PIIX4,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-sis96x.c	Mon Sep 22 16:16:09 2003
@@ -261,7 +261,6 @@
 
 static struct i2c_adapter sis96x_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_SIS96X,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Mon Sep 22 16:16:09 2003
@@ -287,7 +287,6 @@
 
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
 	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Sep 22 16:16:09 2003
+++ b/drivers/i2c/i2c-core.c	Mon Sep 22 16:16:09 2003
@@ -581,8 +581,7 @@
 		 */
 		return (ret = 1 )? count : ret;
 	} else {
-		printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
-		       client->adapter->id);
+		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
 		return -ENOSYS;
 	}
 }
@@ -614,8 +613,7 @@
 	 	*/
 		return (ret = 1 )? count : ret;
 	} else {
-		printk(KERN_DEBUG "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
-		       client->adapter->id);
+		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
 		return -ENOSYS;
 	}
 }

