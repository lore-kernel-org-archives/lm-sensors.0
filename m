From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: [PATCH 2.6] Update Documentation/i2c/writing-clients
Message-Id: <20040913224113.0f3b15a4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This is a very small an update to Documentation/i2c/writing-clients. The
changes are about i2c client driver ID. It used to say that chip driver
writers should ask for a unique ID. It now explains that such an ID is
not required and they can go without it. Until we get plain rid of it...

The patch additionally features CodingStyle updates. We can't ask people
to respect it and at the same time ignore it in our own docs.

I have made a similar change to the i2c (the project) documentation, and
will propose an update to Marcelo for Linux 2.4 (not sure he will accept
it though).

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>


--- linux-2.6.9-rc1/Documentation/i2c/writing-clients	25 Jul 2003 07:56:42 -0000
+++ linux-2.6.9-rc1/Documentation/i2c/writing-clients	13 Sep 2004 20:19:25 -0000
@@ -24,22 +24,24 @@
 routines, a client structure specific information like the actual I2C
 address.
 
-  static struct i2c_driver foo_driver = {
-    .owner          = THIS_MODULE,
-    .name           = "Foo version 2.3 driver",
-    .id             = I2C_DRIVERID_FOO, /* usually from i2c-id.h */
-    .flags          = I2C_DF_NOTIFY,
-    .attach_adapter = &foo_attach_adapter,
-    .detach_client  = &foo_detach_client,
-    .command        = &foo_command /* may be NULL */
-  }
+static struct i2c_driver foo_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "Foo version 2.3 driver",
+	.id		= I2C_DRIVERID_FOO, /* from i2c-id.h, optional */
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= &foo_attach_adapter,
+	.detach_client	= &foo_detach_client,
+	.command	= &foo_command /* may be NULL */
+}
  
 The name can be chosen freely, and may be upto 40 characters long. Please
 use something descriptive here.
 
-The id should be a unique ID. The range 0xf000 to 0xffff is reserved for
-local use, and you can use one of those until you start distributing the
-driver. Before you do that, contact the i2c authors to get your own ID(s).
+If used, the id should be a unique ID. The range 0xf000 to 0xffff is
+reserved for local use, and you can use one of those until you start
+distributing the driver, at which time you should contact the i2c authors
+to get your own ID(s). Note that most of the time you don't need an ID
+at all so you can just omit it.
 
 Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
 means that your driver will be notified when new adapters are found.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
