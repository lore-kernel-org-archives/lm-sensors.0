From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:24:54 +0000
Subject: [lm-sensors] [PATCH] i2c: Documentation fixes
Message-Id: <1130533660431@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Documentation fixes

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7865e24935ec7e76fb482c749015a23052e51f76
tree 9a5fc835415cccc57ec2b7bf86365d4d6ac3f2ba
parent 47b8b103f7f50d56568eb8d6cff0e3a2373f0eb3
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:00:31 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:09 -0700

 Documentation/i2c/writing-clients |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 0772757..1882811 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -33,8 +33,8 @@ static struct i2c_driver foo_driver = {
 	.command	= &foo_command /* may be NULL */
 }
  
-The name can be chosen freely, and may be upto 40 characters long. Please
-use something descriptive here.
+The name field must match the driver name, including the case. It must not
+contain spaces, and may be up to 31 characters long.
 
 Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
 means that your driver will be notified when new adapters are found.
@@ -43,9 +43,6 @@ This is almost always what you want.
 All other fields are for call-back functions which will be explained 
 below.
 
-There use to be two additional fields in this structure, inc_use et dec_use,
-for module usage count, but these fields were obsoleted and removed.
-
 
 Extra client data
 ========@@ -576,12 +573,12 @@ SMBus communication
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

