From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:05:47 +0000
Subject: [lm-sensors] [PATCH 0/8] hwmon: Remove unnecessary OOM messages
Message-Id: <001901cf6381$d43aad60$7cb00820$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. For example,
k.alloc and v.alloc failures use dump_stack().

Jingoo Han (8):
      hwmon: (f71805f) remove unnecessary OOM messages
      hwmon: (ibmpex) remove unnecessary OOM messages
      hwmon: (lm93) remove unnecessary OOM messages
      hwmon: (max1111) remove unnecessary OOM messages
      hwmon: (max197) remove unnecessary OOM messages
      hwmon: (pc87427) remove unnecessary OOM messages
      hwmon: (s3c-hwmon) remove unnecessary OOM messages
      hwmon: (vt1211) remove unnecessary OOM messages

---
 drivers/hwmon/f71805f.c   |    4 +---
 drivers/hwmon/ibmpex.c    |    4 +---
 drivers/hwmon/lm93.c      |    4 +---
 drivers/hwmon/max1111.c   |    4 +---
 drivers/hwmon/max197.c    |    4 +---
 drivers/hwmon/pc87427.c   |    4 +---
 drivers/hwmon/s3c-hwmon.c |    4 +---
 drivers/hwmon/vt1211.c    |    4 +---
 8 files changed, 8 insertions(+), 24 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
