From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:36 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 11 of 11
Message-Id: <11365852564050@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 11 of 11

Document the drop of the owner and name fields of the i2c_driver
structure.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
CC: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit d45d204f0c3daa01a393dfe81415573f9459506a
tree 48cdeb3f4b1a10d36bf81377ebde7c8cc8ac8065
parent b33a665dba55c83f08cdd62aba1cd2672bccdd80
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 20:55:35 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:24 -0800

 Documentation/i2c/porting-clients |    4 ++++
 Documentation/i2c/writing-clients |    6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
index 856274f..f997c72 100644
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -125,6 +125,10 @@ Technical changes:
 
 * [Driver] The flags field of the i2c_driver structure is gone.
   I2C_DF_NOTIFY is now the default behavior.
+  The i2c_driver structure has a driver member, which is itself a
+  structure, those owner and name members should be initialized to
+  THIS_MODULE and a driver name string, respectively. i2c_driver
+  itself has no name member anymore.
 
 Coding policy:
 
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 59d2c16..95eed2b 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -25,8 +25,10 @@ routines, a client structure specific in
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


