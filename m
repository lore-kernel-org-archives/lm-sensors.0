From: mpietrek@fsforth.de (Markus Pietrek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: EEPROM Driver for 24LC64
Message-Id: <200407201548.12108.mpietrek@fsforth.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello LM Sensors Group,

find attached the EEPROM driver for the Microchip 24LC64. It has been tested 
with the I2C stack in linux-2.6.2 on the A9M9750 ARM module.

o 32byte page read/writes are supported for aligned addresses.
o big endian systems are not yet supported.
o probing is not supported

Please contact me if you have further questions.

Bye,

-- 
Markus Pietrek / FS Forth-Systeme GmbH
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 145,  Fax +49 (7667) 908 245, http://www.fsforth.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 24c64.c
Type: text/x-csrc
Size: 9071 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040720/c38e7876/24c64.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch_24c64
Type: text/x-diff
Size: 1331 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040720/c38e7876/patch_24c64.bin
