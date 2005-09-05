From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:18 +0000
Subject: [lm-sensors] [PATCH] I2C: update max6875 documentation
Message-Id: <11259567644131@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: update max6875 documentation

Updates to the max6875 driver documentation.
This brings the documentation in sync with the code, which was recently
simplified.

This patch is based off 2.6.13-rc2-mm2.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 93ffa435147abd47ebd7d7d24176b3c653aef940
tree 451f9bdfa2ec7e2c4399dd6ca3cc3c97f12c27b9
parent bc769ff8f5f6e3d249bfde082653e5bf1c2b5698
author bgardner@wabtec.com <bgardner@wabtec.com> Tue, 12 Jul 2005 13:21:50 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:03 -0700

 Documentation/i2c/chips/max6875 |   94 ++++++++++++++++++++++++++++-----------
 1 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/Documentation/i2c/chips/max6875 b/Documentation/i2c/chips/max6875
--- a/Documentation/i2c/chips/max6875
+++ b/Documentation/i2c/chips/max6875
@@ -4,22 +4,13 @@ Kernel driver max6875
 Supported chips:
   * Maxim MAX6874, MAX6875
     Prefix: 'max6875'
-    Addresses scanned: 0x50, 0x52
+    Addresses scanned: None (see below)
     Datasheet:
         http://pdfserv.maxim-ic.com/en/ds/MAX6874-MAX6875.pdf
 
 Author: Ben Gardner <bgardner@wabtec.com>
 
 
-Module Parameters
------------------
-
-* allow_write int
-  Set to non-zero to enable write permission:
-  *0: Read only
-   1: Read and write
-
-
 Description
 -----------
 
@@ -33,34 +24,85 @@ registers.
 
 The Maxim MAX6874 is a similar, mostly compatible device, with more intputs
 and outputs:
-
              vin     gpi    vout
 MAX6874        6       4       8
 MAX6875        4       3       5
 
-MAX6874 chips can have four different addresses (as opposed to only two for
-the MAX6875). The additional addresses (0x54 and 0x56) are not probed by
-this driver by default, but the probe module parameter can be used if
-needed.
-
-See the datasheet for details on how to program the EEPROM.
+See the datasheet for more information.
 
 
 Sysfs entries
 -------------
 
-eeprom_user   - 512 bytes of user-defined EEPROM space. Only writable if
-                allow_write was set and register 0x43 is 0.
-
-eeprom_config - 70 bytes of config EEPROM. Note that changes will not get
-                loaded into register space until a power cycle or device reset.
-
-reg_config    - 70 bytes of register space. Any changes take affect immediately.
+eeprom        - 512 bytes of user-defined EEPROM space.
 
 
 General Remarks
 ---------------
 
-A typical application will require that the EEPROMs be programmed once and
-never altered afterwards.
+Valid addresses for the MAX6875 are 0x50 and 0x52.
+Valid addresses for the MAX6874 are 0x50, 0x52, 0x54 and 0x56.
+The driver does not probe any address, so you must force the address.
+
+Example:
+$ modprobe max6875 force=0,0x50
+
+The MAX6874/MAX6875 ignores address bit 0, so this driver attaches to multiple
+addresses.  For example, for address 0x50, it also reserves 0x51.
+The even-address instance is called 'max6875', the odd one is 'max6875-dummy'.
+
+
+Programming the chip using i2c-dev
+----------------------------------
+
+Use the i2c-dev interface to access and program the chips.
+Reads and write are performed differently depending on the address range.
+
+The configuration registers are at addresses 0x00 - 0x45.
+Use i2c_smbus_write_byte_data() to write a register and
+i2c_smbus_read_byte_data() to read a register.
+The command is the register number.
+
+Examples:
+To write a 1 to register 0x45:
+  i2c_smbus_write_byte_data(fd, 0x45, 1);
+
+To read register 0x45:
+  value = i2c_smbus_read_byte_data(fd, 0x45);
+
+
+The configuration EEPROM is at addresses 0x8000 - 0x8045.
+The user EEPROM is at addresses 0x8100 - 0x82ff.
+
+Use i2c_smbus_write_word_data() to write a byte to EEPROM.
+
+The command is the upper byte of the address: 0x80, 0x81, or 0x82.
+The data word is the lower part of the address or'd with data << 8.
+  cmd = address >> 8;
+  val = (address & 0xff) | (data << 8);
+
+Example:
+To write 0x5a to address 0x8003:
+  i2c_smbus_write_word_data(fd, 0x80, 0x5a03);
+
+
+Reading data from the EEPROM is a little more complicated.
+Use i2c_smbus_write_byte_data() to set the read address and then
+i2c_smbus_read_byte() or i2c_smbus_read_i2c_block_data() to read the data.
+
+Example:
+To read data starting at offset 0x8100, first set the address:
+  i2c_smbus_write_byte_data(fd, 0x81, 0x00);
+
+And then read the data
+  value = i2c_smbus_read_byte(fd);
+
+  or
+
+  count = i2c_smbus_read_i2c_block_data(fd, 0x84, buffer);
+
+The block read should read 16 bytes.
+0x84 is the block read command.
+
+See the datasheet for more details.
 

