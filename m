From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:14:52 +0000
Subject: [lm-sensors] [PATCH] i2c: Fix I2C_FUNC_PROTOCOL_MANGLING
Message-Id: <11305336591306@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Fix I2C_FUNC_PROTOCOL_MANGLING documentation

Fix the description of I2C_FUNC_PROTOCOL_MANGLING.

From: Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 Documentation/i2c/functionality |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

---
commit d057c96cab72bc6b70570d25b90404f81d98e886
tree db7b1b5403693ac84fc1b84619a2fc3317bc2176
parent 4366dc946c01305cff49b07dabb806d2364f1edb
author Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp> Sun, 25 Sep 2005 16:53:04 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:07 -0700

 Documentation/i2c/functionality |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
index 41ffefb..60cca24 100644
--- a/Documentation/i2c/functionality
+++ b/Documentation/i2c/functionality
@@ -17,9 +17,10 @@ For the most up-to-date list of function
   I2C_FUNC_I2C                    Plain i2c-level commands (Pure SMBus
                                   adapters typically can not do these)
   I2C_FUNC_10BIT_ADDR             Handles the 10-bit address extensions
-  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_REV_DIR_ADDR,
-                                  I2C_M_REV_DIR_ADDR and I2C_M_REV_DIR_NOSTART
-                                  flags (which modify the i2c protocol!)
+  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_IGNORE_NAK,
+                                  I2C_M_REV_DIR_ADDR, I2C_M_NOSTART and
+                                  I2C_M_NO_RD_ACK flags (which modify the
+                                  I2C protocol!)
   I2C_FUNC_SMBUS_QUICK            Handles the SMBus write_quick command
   I2C_FUNC_SMBUS_READ_BYTE        Handles the SMBus read_byte command
   I2C_FUNC_SMBUS_WRITE_BYTE       Handles the SMBus write_byte command

