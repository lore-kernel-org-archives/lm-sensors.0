From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <1064273416272@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734162392@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1153.85.2, 2003/08/27 15:29:33-07:00, mds@paradyne.com

[PATCH] I2C: i2c-isa functionality

The "functionality" return was incorrectly removed for i2c-isa.c when porting to 2.5.
A driver that does nothing must return a 0 or else i2c-core assumes
0xffffffff (all functionality).


 drivers/i2c/busses/i2c-isa.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Mon Sep 22 16:17:05 2003
+++ b/drivers/i2c/busses/i2c-isa.c	Mon Sep 22 16:17:05 2003
@@ -30,10 +30,13 @@
 #include <linux/errno.h>
 #include <linux/i2c.h>
 
+static u32 isa_func(struct i2c_adapter *adapter);
+
 /* This is the actual algorithm we define */
 static struct i2c_algorithm isa_algorithm = {
 	.name		= "ISA bus algorithm",
 	.id		= I2C_ALGO_ISA,
+	.functionality	= isa_func,
 };
 
 /* There can only be one... */
@@ -44,6 +47,12 @@
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
 };
+
+/* We can't do a thing... */
+static u32 isa_func(struct i2c_adapter *adapter)
+{
+	return 0;
+}
 
 static int __init i2c_isa_init(void)
 {

