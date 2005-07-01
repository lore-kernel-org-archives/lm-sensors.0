From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Fri, 01 Jul 2005 19:46:50 +0000
Subject: [lm-sensors] max6875: simplify driver
Message-Id: <200507011246.10645.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Here's what I have working for the max6875 driver simplification.
Changes:
 - does not do any detection; requires "force=0,0x50" or "force=0,0x52"
 - only makes available the user EEPROM as "eeprom" (read-only)

The patch is based off of 2.6.12-mm1, but should include all of your recent 
changes.

Would you take a look?

Thanks,
Ben

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-chips-max6875.diff
Type: text/x-diff
Size: 20815 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050701/53c50af2/i2c-chips-max6875-0001.bin
