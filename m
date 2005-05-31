From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Tue, 31 May 2005 16:31:04 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4] PCA9539 - new driver
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The PCA9539 is a 16 bit discrete I/O chip, where each of the 16 pins can
be configured to be either an input or output.  It is connected via the
i2c bus.
 
It's probably not found on any standard motherboard, but it's pretty
handy for custom embedded stuff.

The driver exposes the 8 registers (input/output/config/invert for
channels 0 & 1) via sysfs.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pca9539.patch
Type: application/octet-stream
Size: 7539 bytes
Desc: pca9539.patch
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050531/a0730624/pca9539.obj
