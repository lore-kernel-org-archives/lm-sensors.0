From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 27 Jan 2006 05:50:46 +0000
Subject: [lm-sensors] [patch 1/2] hwmon: add a superio_locks coordinator -
Message-Id: <43D9B4B6.1050906@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From:  Jim Cromie <jim.cromie at gmail.com>

this adds superio_locks module to hwmon.
The module makes it simple for a driver using a Super-IO chip
to obtain a shared lock, and thereby coordinate with any other
(cooperative) users of that chip, without knowing who they are.

From:  Jim Cromie <jim.cromie at gmail.com>

---

$ diffstat diff.superio-locks-beta3
 drivers/hwmon/Makefile          |    2
 drivers/hwmon/superio_locks.c   |  204 
++++++++++++++++++++++++++++++++++++++++
 include/linux/superio_lockmgr.h |   17 +++
 3 files changed, 223 insertions(+)

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.superio-locks-beta3
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060127/0f5ef454/diff.pl
