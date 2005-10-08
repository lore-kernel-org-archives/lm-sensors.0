From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 00:01:01 +0000
Subject: [lm-sensors] [PATCH 06/16] i2c: Documentation fixes
Message-Id: <20051008000031.60fb7f18.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c documentation fixes.

From Hideki Iwamoto:
* i2c_smbus_read_i2c_block_data is not deleted in 2.6.10. It still
  exists.
* The name which can be set to i2c_driver is up to 31 characters.

From Jean Delvare:
* Reword the paragraph about i2c_driver.name, to reflect the "new"
  naming policy.
* Delete the out-of-date note about now gone inc_use and dec_use
  fields.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/writing-clients |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- linux-2.6.14-rc3.orig/Documentation/i2c/writing-clients	2005-10-06 19:31:43.000000000 +0200
+++ linux-2.6.14-rc3/Documentation/i2c/writing-clients	2005-10-06 19:31:51.000000000 +0200
@@ -33,8 +33,8 @@
 	.command	= &foo_command /* may be NULL */
 }
  
-The name can be chosen freely, and may be upto 40 characters long. Please
-use something descriptive here.
+The name field must match the driver name, including the case. It must not
+contain spaces, and may be up to 31 characters long.
 
 Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
 means that your driver will be notified when new adapters are found.
@@ -43,9 +43,6 @@
 All other fields are for call-back functions which will be explained 
 below.
 
-There use to be two additional fields in this structure, inc_use et dec_use,
-for module usage count, but these fields were obsoleted and removed.
-
 
 Extra client data
 ========@@ -576,12 +573,12 @@
   extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
                                         u8 command, u8 length,
                                         u8 *values);
+  extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+                                           u8 command, u8 *values);
 
 These ones were removed in Linux 2.6.10 because they had no users, but could
 be added back later if needed:
 
-  extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
-                                           u8 command, u8 *values);
   extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
                                        u8 command, u8 *values);
   extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,

-- 
Jean Delvare
