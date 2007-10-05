From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 05 Oct 2007 07:27:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Kconfig dependency cleanups
Message-Id: <4705E752.4050407@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070829121900.63b7ae85@hyperion.delvare>
In-Reply-To: <20070829121900.63b7ae85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

In this post:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021089.html

Jean Delvare wrote:
--------------------------------------------
* Drop HWMON from the dependency list of ABITUGURU3 and LM93: this is
   now handled at menu level.
* Make the Abit, Asus and FSC chip drivers depend on X86. These are
   custom chips which can only be found on their respective manufacturer's
   systems, and these manufacturers only do x86 hardware AFAIK.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
  drivers/hwmon/Kconfig |   12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.23-rc4.orig/drivers/hwmon/Kconfig	2007-08-29 12:10:56.000000000 +0200
+++ linux-2.6.23-rc4/drivers/hwmon/Kconfig	2007-08-29 12:11:51.000000000 +0200
@@ -30,7 +30,7 @@ config HWMON_VID

  config SENSORS_ABITUGURU
  	tristate "Abit uGuru (rev 1 & 2)"
-	depends on EXPERIMENTAL
+	depends on X86 && EXPERIMENTAL
  	help
  	  If you say yes here you get support for the sensor part of the first
  	  and second revision of the Abit uGuru chip. The voltage and frequency
@@ -45,7 +45,7 @@ config SENSORS_ABITUGURU

  config SENSORS_ABITUGURU3
  	tristate "Abit uGuru (rev 3)"
-	depends on HWMON && EXPERIMENTAL
+	depends on X86 && EXPERIMENTAL
  	help
  	  If you say yes here you get support for the sensor part of the
  	  third revision of the Abit uGuru chip. Only reading the sensors
@@ -182,7 +182,7 @@ config SENSORS_AMS_I2C

  config SENSORS_ASB100
  	tristate "Asus ASB100 Bach"
-	depends on I2C && EXPERIMENTAL
+	depends on X86 && I2C && EXPERIMENTAL
  	select HWMON_VID
  	help
  	  If you say yes here you get support for the ASB100 Bach sensor
@@ -248,7 +248,7 @@ config SENSORS_F75375S

  config SENSORS_FSCHER
  	tristate "FSC Hermes"
-	depends on I2C
+	depends on X86 && I2C
  	help
  	  If you say yes here you get support for Fujitsu Siemens
  	  Computers Hermes sensor chips.
@@ -258,7 +258,7 @@ config SENSORS_FSCHER

  config SENSORS_FSCPOS
  	tristate "FSC Poseidon"
-	depends on I2C
+	depends on X86 && I2C
  	help
  	  If you say yes here you get support for Fujitsu Siemens
  	  Computers Poseidon sensor chips.
@@ -431,7 +431,7 @@ config SENSORS_LM92

  config SENSORS_LM93
  	tristate "National Semiconductor LM93 and compatibles"
-	depends on HWMON && I2C
+	depends on I2C
  	select HWMON_VID
  	help
  	  If you say yes here you get support for National Semiconductor LM93

-- 
Jean Delvare

-------------------------------------------------------------

One beginner question, does X86 also get defined on x86_64? If not this won't work.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
