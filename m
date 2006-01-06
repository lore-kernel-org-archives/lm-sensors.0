From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:37 +0000
Subject: [lm-sensors] [PATCH] i2c: Documentation update
Message-Id: <11365852571074@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Documentation update

Update the i2c documentation to reflect the recent change to
i2c_add_driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit d82c0bf88fa97c1993ea9d6051488e7cb012b440
tree 60ecbf9971ee125f84f063d153328f9d7ec5ea98
parent 2b48716d1d2f2edb1e7cbc5ecf1cb2cb39373e33
author Jean Delvare <khali at linux-fr.org> Wed, 07 Dec 2005 21:54:26 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:25 -0800

 Documentation/i2c/porting-clients |    5 ++---
 Documentation/i2c/writing-clients |    1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
index f997c72..f03c2a0 100644
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -126,9 +126,8 @@ Technical changes:
 * [Driver] The flags field of the i2c_driver structure is gone.
   I2C_DF_NOTIFY is now the default behavior.
   The i2c_driver structure has a driver member, which is itself a
-  structure, those owner and name members should be initialized to
-  THIS_MODULE and a driver name string, respectively. i2c_driver
-  itself has no name member anymore.
+  structure, those name member should be initialized to a driver name
+  string. i2c_driver itself has no name member anymore.
 
 Coding policy:
 
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 95eed2b..27c425a 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -26,7 +26,6 @@ address.
 
 static struct i2c_driver foo_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "foo",
 	},
 	.attach_adapter	= &foo_attach_adapter,


