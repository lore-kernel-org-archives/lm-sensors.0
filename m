From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sat, 01 Oct 2005 15:31:22 +0000
Subject: [lm-sensors] [PATCH 2.6] Documentation fix (writing-clients)
Message-Id: <200510011330.AA01323@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

o Remove flags parameter from detect function. 
o i2c_smbus_read_i2c_block_data is not deleted in 2.6.10. It still exists.

--- linux-2.6.14-rc3/Documentation/i2c/writing-clients.org	2005-10-01 21:58:59.830765256 +0900
+++ linux-2.6.14-rc3/Documentation/i2c/writing-clients	2005-10-01 22:14:18.964035760 +0900
@@ -246,10 +246,7 @@ the detection to stop: other addresses a
 This should only be done on fatal or internal errors, such as a memory
 shortage or i2c_attach_client failing.
 
-For now, you can ignore the `flags' parameter. It is there for future use.
-
-  int foo_detect_client(struct i2c_adapter *adapter, int address, 
-                        unsigned short flags, int kind)
+  int foo_detect_client(struct i2c_adapter *adapter, int address, int kind)
   {
     int err = 0;
     int i;
@@ -576,12 +573,12 @@ SMBus communication
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

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
