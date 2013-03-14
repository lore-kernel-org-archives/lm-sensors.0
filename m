From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:02:40 +0000
Subject: [lm-sensors] [PATCH 0/4] hwmon: w83627hf patches
Message-Id: <1363219364-5221-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cleanup, and use request_muxed_region when requesting access to SIO registers.
This enables the safe use of other drivers for the same chip.

----------------------------------------------------------------
Guenter Roeck (4):
      hwmon: (w83627hf) Fix various checkpatch errors and warnings
      hwmon: (w83627hf) Drop read/write lock
      hwmon: (w83627hf) Rearrange code to no longer require forward declarations
      hwmon: (w83627hf) Use request_muxed_region

 drivers/hwmon/w83627hf.c |  966 +++++++++++++++++++++++-----------------------
 1 file changed, 488 insertions(+), 478 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
