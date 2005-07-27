From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Wed, 27 Jul 2005 19:44:13 +0000
Subject: [lm-sensors] [PATCH] I2C: add kobj_to_i2c_client
Message-Id: <200507271243.04206.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Move the inline function kobj_to_i2c_client() from max6875.c to i2c.h.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-kobj_to_i2c_client.diff
Type: text/x-diff
Size: 1256 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050727/6ba77bb5/i2c-kobj_to_i2c_client.bin
