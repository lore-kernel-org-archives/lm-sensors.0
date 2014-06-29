From: Joe Perches <joe@perches.com>
Date: Sun, 29 Jun 2014 00:20:12 +0000
Subject: [lm-sensors] [PATCH 0/4] fs.h: Kernel style updates
Message-Id: <cover.1403999769.git.joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

Mostly s/s/w/hitespace cleaning.

Joe Perches (4):
  fs.h: Remove unnecessary extern prototypes
  fs.h: Whitespace neatening
  fs.h: A few more whitespace neatenings
  fs: asus_atk0110: Fix DEFINE_SIMPLE_ATTRIBUTE semicolon definition and use

 drivers/hwmon/asus_atk0110.c |    2 +-
 include/linux/fs.h           | 1185 +++++++++++++++++++++---------------------
 2 files changed, 598 insertions(+), 589 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
