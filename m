From: Ben Hutchings <bhutchings@solarflare.com>
Date: Thu, 10 Jul 2008 14:58:26 +0000
Subject: [lm-sensors] [PATCH 0/3] lm90: Changes to support sfc hardware
Message-Id: <cover.1215701481.git.bhutchings@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These patches apply on top of the testing branch of hwmon-2.6.git plus
Jean Delvare's patch series <http://jdelvare.pck.nerim.net/sensors/lm90/>.

Jean, I expect you may want to do the 3rd patch differently.

I've tested the new-style lm90 driver with a slightly modified sfc driver
and it seems to work correctly for our SFE4001 board which uses MAX6647.
I have not tested the legacy driver after these changes.

Ben.

Ben Hutchings (3):
  lm90: Rename temperature conversion functions to match usage
  lm90: Support MAX6646, MAX6647 and MAX6649
  lm90: Converted into a new-style driver

 drivers/hwmon/Kconfig |    3 +-
 drivers/hwmon/lm90.c  |  280 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 186 insertions(+), 97 deletions(-)

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
