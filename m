From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: [PATCH] i2c-isa functionality
Message-Id: <3F47BE35.3030208@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg, please apply. thanks.
mds



The "functionality" return was incorrectly removed for i2c-isa.c when porting to 2.5.
A driver that does nothing must return a 0 or else i2c-core assumes
0xffffffff (all functionality).
-------------- next part --------------
--- amdlinux-2.6.0-test4/drivers/i2c/busses/i2c-isa.c	Sat Aug 23 15:05:14 2003
+++ mds/drivers/i2c/busses/i2c-isa.c	Sat Aug 23 15:11:25 2003
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
