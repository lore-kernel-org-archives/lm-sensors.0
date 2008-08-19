From: Ben Hutchings <bhutchings@solarflare.com>
Date: Tue, 19 Aug 2008 15:01:29 +0000
Subject: [lm-sensors] [PATCH 0/2] lm87 changes to support sfc driver (3rd
Message-Id: <cover.1219157913.git.bhutchings@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

First, a necessary bug fix in lm87_init_client().

Second, support for platform_data.  This time it's a minimal change, with
platform_data just pointing to the value to write in the channel register.

Ben.

Ben Hutchings (2):
  lm87: Fix masking of config register in lm87_init_client()
  lm87: Add support for configuration through platform_data

 drivers/hwmon/lm87.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
