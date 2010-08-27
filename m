From: Yuri Ershov <ext-yuri.ershov@nokia.com>
Date: Fri, 27 Aug 2010 14:33:19 +0000
Subject: [lm-sensors] [PATCH 0/2] Accelerometer driver unload
Message-Id: <1282919601-21821-1-git-send-email-ext-yuri.ershov@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net, samu.p.onkalo@nokia.com, akpm@linux-foundation.org, daniel@caiaq.de
Cc: ext-yuri.kululin@nokia.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, ext-yuri.ershov@nokia.com

Hello,

I2C part of lis3 accelerometer driver can be unloaded while in use which may
cause kernel oops.

These patches allow to change /dev/freefall file ops owner to prevent driver
unloading while device in use.

Please review.

Best regards,
Yuri

Yuri Kululin (2):
  lis3: Add device owner
  lis3: Set device owner

 drivers/hwmon/lis3lv02d.c     |    8 ++++++--
 drivers/hwmon/lis3lv02d.h     |    2 ++
 drivers/hwmon/lis3lv02d_i2c.c |    2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
