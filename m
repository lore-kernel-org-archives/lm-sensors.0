From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Thu, 30 Jun 2005 16:18:20 +0000
Subject: [lm-sensors] [Patch 1/5] w1: sysfs, select-slave, ds2433
Message-Id: <200506300917.36575.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

w1-select-slave.diff
I added w1_reset_select_slave()
This function resets the w1 bus and either sends a skip rom (0xCC) or the
full select ROM + id.  If there is only 1 slave present, it does skip rom.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1-select-slave.diff
Type: text/x-diff
Size: 1701 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050630/ffb8a049/w1-select-slave.bin
