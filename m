From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Tue, 12 Jul 2005 20:21:52 +0000
Subject: [lm-sensors] [PATCH] I2C: simplify max6875 driver
Message-Id: <200507121321.11458.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: simplify max6875 driver

This is an update to the max6875 driver.
It no longer does any detection, so the address must be forced on module load.
It only makes available the user EEPROM (read-only).

This patch is based off 2.6.13-rc2-mm2.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-chips-max6875.diff
Type: text/x-diff
Size: 18570 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050712/78956829/i2c-chips-max6875-0001.bin
