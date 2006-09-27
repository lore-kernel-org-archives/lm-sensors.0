From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:43 +0000
Subject: [lm-sensors] [PATCH 12/30] i2c: Fix copy-n-paste in subsystem
Message-Id: <11593189613519-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Arthur Othieno <apgo at patchbomb.org>

i2c: Fix copy-n-paste in subsystem Kconfig

We have:
  drivers/i2c/Kconfig:2:# Character device configuration
Which is obviously not true..

Signed-off-by: Arthur Othieno <apgo at patchbomb.org>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 24383af..11935f6 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -1,5 +1,5 @@
 #
-# Character device configuration
+# I2C subsystem configuration
 #
 
 menu "I2C support"
-- 
1.4.2.1


