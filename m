From: david-b@pacbell.net (david-b@pacbell.net)
Date: Wed, 29 Jun 2005 16:14:57 +0000
Subject: [lm-sensors] [PATCH 2.6.13-rc1] minor I2C doc cleanups
Message-Id: <20050629141406.1947DC894D@blackbox.site>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The I2C stack has long had "id" fields, of rather dubious utility, in
many data structures.  This removes mention of one of them from the
documentation about how to write an I2C driver, so that only drivers
that really need to use them (probably old/legacy code) will have any
reason to use this field.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- o26.orig/Documentation/i2c/writing-clients	2005-05-24 21:35:49.000000000 -0700
+++ o26/Documentation/i2c/writing-clients	2005-05-31 16:34:57.000000000 -0700
@@ -27,7 +27,6 @@ address.
 static struct i2c_driver foo_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "Foo version 2.3 driver",
-	.id		= I2C_DRIVERID_FOO, /* from i2c-id.h, optional */
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= &foo_attach_adapter,
 	.detach_client	= &foo_detach_client,
@@ -37,12 +36,6 @@ static struct i2c_driver foo_driver = {
 The name can be chosen freely, and may be upto 40 characters long. Please
 use something descriptive here.
 
-If used, the id should be a unique ID. The range 0xf000 to 0xffff is
-reserved for local use, and you can use one of those until you start
-distributing the driver, at which time you should contact the i2c authors
-to get your own ID(s). Note that most of the time you don't need an ID
-at all so you can just omit it.
-
 Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
 means that your driver will be notified when new adapters are found.
 This is almost always what you want.
