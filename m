From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:03:44 +0000
Subject: [lm-sensors] [PATCH] I2C: max6875 Kconfig update
Message-Id: <11211193763938@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11211193761992@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org

[PATCH] I2C: max6875 Kconfig update

Here is a proposed Kconfig update for the new max6875 i2c chip driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2146fec20c38d926f0d88413977f941f42a14588
tree daaf87a4ec6e6c70c9e1be8b2bd09257b3be092f
parent 089bd86632769051f15cd7387eebe126d18f151f
author Jean Delvare <khali@linux-fr.org> Thu, 23 Jun 2005 23:41:39 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/Kconfig |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -519,13 +519,16 @@ config SENSORS_M41T00
 	  will be called m41t00.
 
 config SENSORS_MAX6875
-	tristate "MAXIM MAX6875 Power supply supervisor"
+	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on I2C && EXPERIMENTAL
 	help
-	  If you say yes here you get support for the MAX6875
-	  EEPROM-Programmable, Hex/Quad, Power-Suppy Sequencers/Supervisors.
+	  If you say yes here you get support for the Maxim MAX6875
+	  EEPROM-programmable, quad power-supply sequencer/supervisor.
 
-          This provides a interface to program the EEPROM and reset the chip.
+	  This provides an interface to program the EEPROM and reset the chip.
+
+	  This driver also supports the Maxim MAX6874 hex power-supply
+	  sequencer/supervisor if found at a compatible address.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6875.

