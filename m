From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Jun 2005 23:42:08 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: max6875 Kconfig update
Message-Id: <20050623234139.704340b8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is a proposed Kconfig update for the new max6875 i2c chip driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/Kconfig |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.12-git5.orig/drivers/i2c/chips/Kconfig	2005-06-23 21:32:01.000000000 +0200
+++ linux-2.6.12-git5/drivers/i2c/chips/Kconfig	2005-06-23 23:26:16.000000000 +0200
@@ -520,13 +520,16 @@
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


-- 
Jean Delvare
