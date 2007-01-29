From: alanc@pipstechnology.co.uk (Alan Clucas)
Date: Mon, 29 Jan 2007 11:58:00 +0000
Subject: [lm-sensors] DS75
Message-Id: <45BDE148.7020108@pipstechnology.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We have a DS75 on a custom board, which is attached to a Compulab iGLX 
AMD Geode based board - using the CS5536 and an unmodified scx200_acb 
driver to access the smbus/i2c.

On this board is a DS75. It doesn't identify as the chip correctly with 
the lm75 driver in 2.6.19.2 due to the fact that it seems to return the 
last value read for all of its out of spec commands, rather than doing 
the address cycling which the driver expects for command >8 - e.g. 
address 8 behaves like addresses 4 through 7. (I can provide a debug log 
showing this if needed).

With the following patch it identifies correctly and works as expected.

--- linux-2.6.19.2/drivers/hwmon/lm75.c 2007-01-24 16:03:42.000000000 +0000
+++ linux/drivers/hwmon/lm75.c  2007-01-29 11:41:45.000000000 +0000
@@ -181,13 +181,6 @@
                 /* Unused bits */
                 if (conf & 0xe0)
                         goto exit_free;
-
-               /* Addresses cycling */
-               for (i = 8; i < 0xff; i += 8)
-                       if (i2c_smbus_read_byte_data(new_client, i + 1) 
!= conf
-                        || i2c_smbus_read_word_data(new_client, i + 2) 
!= hyst
-                        || i2c_smbus_read_word_data(new_client, i + 3) 
!= os)
-                               goto exit_free;
         }

         /* Determine the chip type - only one kind supported! */

The chip has the following markings on its top:

DS75
SO6A5

Does anyone out there have a DS75 which is being identified correctly - 
the patch to change identify in this way went in quite some time ago...
http://lists.lm-sensors.org/pipermail/lm-sensors/2004-July/008335.html

Alan Clucas

-------------- next part --------------
A non-text attachment was scrubbed...
Name: alanc.vcf
Type: text/x-vcard
Size: 562 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070129/cc670374/attachment.vcf 
