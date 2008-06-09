From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 09 Jun 2008 11:06:04 +0000
Subject: [lm-sensors] [PATCH 0/3] lm87 changes for Solarflare NICs [2nd try]
Message-Id: <20080609110604.GX11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch series splits the previous patch into 3 parts.

Ben.

Ben Hutchings (3):
  lm87: Converted into a new-style driver
  lm87: Add support for configuration through platform_data
  lm87: Expose sensor values to kernel users

 drivers/hwmon/lm87.c |  363 +++++++++++++++++++++++++++++++-------------------
 include/linux/lm87.h |  132 ++++++++++++++++++
 2 files changed, 357 insertions(+), 138 deletions(-)
 create mode 100644 include/linux/lm87.h

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
