From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 03 Jun 2005 17:59:07 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2 0/5] w1 enhancements
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076C5E7@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I made a few improvements to the w1 subsystem.
These are the patches that will follow.

1 - w1_touchbit.diff.txt
Cleans up usage of touch_bit/w1_read_bit/w1_write_bit.

2 - w1_triplet.diff.txt
Adds the triplet w1 master method and changes w1_search() to use it.

3 - w1_searchtiming.diff.txt
Adds a sysfs entry (w1_master_search) that allows you to disable/enable
periodic searches.

4 - w1_defaultfamily.diff.txt
Adds a default family so that new slave families will show up in sysfs.

5 - w1_doc.diff.txt
Updates the w1 documentation (w1.generic)

The order is important for the first 3 patches.

Overall diffstat:
 Documentation/w1/w1.generic |  107 ++++++++++++++++----
 drivers/w1/w1.c             |  233
+++++++++++++++++++++++++++-----------------
 drivers/w1/w1.h             |   84 ++++++++++++---
 drivers/w1/w1_int.c         |    9 +
 drivers/w1/w1_io.c          |  113 +++++++++++++++++++--
 drivers/w1/w1_io.h          |    5 
 6 files changed, 414 insertions(+), 137 deletions(-)

Signed-off-by: Ben Gardner <bgardner@wabtec.com>

