From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Thu, 30 Jun 2005 16:19:29 +0000
Subject: [lm-sensors] [Patch 3/5] w1: sysfs, select-slave, ds2433
Message-Id: <200506300918.05947.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

w1-container-of.diff
I added three inline function to hide the use of container_of().
 - dev_to_w1_slave()
 - kobj_to_w1_slave()
 - dev_to_w1_master()

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1-container-of.diff
Type: text/x-diff
Size: 6101 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050630/924de8f4/w1-container-of.bin
