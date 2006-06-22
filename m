From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:43 +0000
Subject: [lm-sensors] [PATCH 17/44] [PATCH] HWMON: Improve the help text for
Message-Id: <1151000949579-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Improve the help text for CONFIG_HWMON to let the users know how they
pick the right hardware monitoring driver(s) for their system.

Also fix a couple typos in the related documentation file and improve
some parts a bit.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/userspace-tools |   17 +++++++++--------
 drivers/hwmon/Kconfig               |    4 ++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/userspace-tools b/Documentation/hwmon/userspace-tools
index 2622aac..19900a8 100644
--- a/Documentation/hwmon/userspace-tools
+++ b/Documentation/hwmon/userspace-tools
@@ -6,31 +6,32 @@ voltages, fans speed). They are often co
 are also connected directly through the ISA bus.
 
 The kernel drivers make the data from the sensor chips available in the /sys
-virtual filesystem. Userspace tools are then used to display or set or the
-data in a more friendly manner.
+virtual filesystem. Userspace tools are then used to display the measured
+values or configure the chips in a more friendly manner.
 
 Lm-sensors
 ----------
 
-Core set of utilites that will allow you to obtain health information,
+Core set of utilities that will allow you to obtain health information,
 setup monitoring limits etc. You can get them on their homepage
 http://www.lm-sensors.nu/ or as a package from your Linux distribution.
 
 If from website:
-Get lmsensors from project web site. Please note, you need only userspace
-part, so compile with "make user_install" target.
+Get lm-sensors from project web site. Please note, you need only userspace
+part, so compile with "make user" and install with "make user_install".
 
 General hints to get things working:
 
 0) get lm-sensors userspace utils
-1) compile all drivers in I2C section as modules in your kernel
+1) compile all drivers in I2C and Hardware Monitoring sections as modules
+   in your kernel
 2) run sensors-detect script, it will tell you what modules you need to load.
 3) load them and run "sensors" command, you should see some results.
 4) fix sensors.conf, labels, limits, fan divisors
 5) if any more problems consult FAQ, or documentation
 
-Other utilites
---------------
+Other utilities
+---------------
 
 If you want some graphical indicators of system health look for applications
 like: gkrellm, ksensors, xsensors, wmtemp, wmsensors, wmgtemp, ksysguardd,
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9384b85..164760d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -16,6 +16,10 @@ config HWMON
 	  should say Y here and also to the specific driver(s) for your
 	  sensors chip(s) below.
 
+	  To find out which specific driver(s) you need, use the
+	  sensors-detect script from the lm_sensors package.  Read
+	  <file:Documentation/hwmon/userspace-tools> for details.
+
 	  This support can also be built as a module.  If so, the module
 	  will be called hwmon.
 
-- 
1.4.0


