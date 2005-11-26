From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:54:34 +0000
Subject: [lm-sensors] [PATCH 20/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126205535.7a7f6a76.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-11-documentation.patch

Document the drop of the owner and name fields of the i2c_driver
structure.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
CC: Laurent Riffard <laurent.riffard@free.fr>
---
 Documentation/i2c/porting-clients |    4 ++++
 Documentation/i2c/writing-clients |    6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc2.orig/Documentation/i2c/porting-clients	2005-11-20 11:23:58.000000000 +0100
+++ linux-2.6.15-rc2/Documentation/i2c/porting-clients	2005-11-20 11:31:02.000000000 +0100
@@ -111,6 +111,10 @@
 
 * [Driver] The flags field of the i2c_driver structure is gone.
   I2C_DF_NOTIFY is now the default behavior.
+  The i2c_driver structure has a driver member, which is itself a
+  structure, those owner and name members should be initialized to
+  THIS_MODULE and a driver name string, respectively. i2c_driver
+  itself has no name member anymore.
 
 Coding policy:
 
--- linux-2.6.15-rc2.orig/Documentation/i2c/writing-clients	2005-11-20 09:29:48.000000000 +0100
+++ linux-2.6.15-rc2/Documentation/i2c/writing-clients	2005-11-20 11:30:22.000000000 +0100
@@ -25,8 +25,10 @@
 address.
 
 static struct i2c_driver foo_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "Foo version 2.3 driver",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "foo",
+	},
 	.attach_adapter	= &foo_attach_adapter,
 	.detach_client	= &foo_detach_client,
 	.command	= &foo_command /* may be NULL */

-- 
Jean Delvare
