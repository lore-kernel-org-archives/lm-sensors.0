From: gregkh@suse.de (gregkh@suse.de)
Date: Tue, 26 Jul 2005 23:48:58 +0000
Subject: [lm-sensors] patch i2c-max6875-documentation-update.patch added to
Message-Id: <1DxXI7-2ff-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: I2C: update max6875 documentation

to my gregkh-2.6 tree.  Its filename is

     i2c-max6875-documentation-update.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c-max6875-simplify.patch
i2c-max6875-documentation-update.patch


From BGardner@Wabtec.com Tue Jul 12 11:24:10 2005
From: bgardner@wabtec.com
To: Jean Delvare <khali@linux-fr.org>
Subject: I2C: I2C: update max6875 documentation
Date: Tue, 12 Jul 2005 13:21:50 -0500
Cc: "lm-sensors" <lm-sensors@lm-sensors.org>,
 greg@kroah.com
Message-Id: <200507121321.50547.bgardner@wabtec.com>

[PATCH] I2C: update max6875 documentation

Updates to the max6875 driver documentation.
This brings the documentation in sync with the code, which was recently 
simplified.

This patch is based off 2.6.13-rc2-mm2.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.13-rc2-mm2.orig/Documentation/i2c/chips/max6875
+++ linux-2.6.13-rc2-mm2/Documentation/i2c/chips/max6875
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
 

