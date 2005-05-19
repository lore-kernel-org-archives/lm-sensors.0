From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: pcf8574 driver
Message-Id: <E16ZrFS-0001ZT-00@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have to use the pcf8574 chip with my I2C interface, however, the pcf8574 
drivers in lm-sensors is a bit basic. It supposes the pin P1 is used as an 
input and the others pin as outputs.

Attached is a patch which corrects that, providing to files in /proc 
interface, one for writting, the other for reading. It also modifies a bit 
the driver to support the pcf8574a (it is a pcf8574 with a different address 
range), and add a documentation file in doc/chips.

The patch also includes some cosmetic changes in the pcf8591 driver I wrote 
previously, that is to say it modify the chip name in some places I had 
forgotten to change when I made a copy/paste from another driver.

Feel free to include it or not.

Aurelien Jarno
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pcf8574.diff.gz
Type: application/x-gzip
Size: 3771 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020210/b10f8b62/pcf8574.diff.gz
