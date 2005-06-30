From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Thu, 30 Jun 2005 16:19:32 +0000
Subject: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433
Message-Id: <200506300918.17966.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

w1-slave-sysfs.diff
Every slave now has at least two sysfs files:
 - id : an 8 byte binary file that holds the 64 bit id
   example: [23 6c dc 1c 00 00 00 43]
 - name : the name, example: [23-0000001cdc6c]
Family ops is now two callback functions: add_slave() and remove_slave().
The family driver is responsible for creating any other sysfs entries.
This patch updates w1-smem (which is pretty much empty) and w1-therm.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1-slave-sysfs.diff
Type: text/x-diff
Size: 9934 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050630/2e97d7a4/w1-slave-sysfs-0001.bin
