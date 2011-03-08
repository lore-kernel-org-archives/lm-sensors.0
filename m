From: "Emiliano Carnati" <carnati@ebneuro.com>
Date: Tue, 08 Mar 2011 12:07:28 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <B796C5844A864F37A0662B0F2D9BA9FB@CARNATI>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>
> We should mention ADS1115 support in all the appropriate places. Grep
> for ADS1015 to get an idea.
>

From what I can see, the other changes could be


<<<< Addendum >>>>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9abcc6b..9b3e3e9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -856,7 +856,7 @@ config SENSORS_ADS1015
 	depends on I2C
 	help
 	  If you say yes here you get support for Texas Instruments ADS1015
-	  12-bit 4-input ADC device.
+	  & ADS1115 12/16-bit 4-input ADC devices.

 	  This driver can also be built as a module.  If so, the module
 	  will be called ads1015.
diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
index 85ffd77..e12fd1c 100644
--- a/Documentation/hwmon/ads1015
+++ b/Documentation/hwmon/ads1015
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'ads1015'
     Datasheet: Publicly available at the Texas Instruments website :
                http://focus.ti.com/lit/ds/symlink/ads1015.pdf
+  * Texas Instruments ADS1115
+    Prefix: 'ads1115'
+    Datasheet: Publicly available at the Texas Instruments website :
+               http://focus.ti.com/lit/ds/symlink/ads1115.pdf

 Authors:
         Dirk Eibach, Guntermann & Drunck GmbH <eibach <at> gdsys.de>
@@ -13,9 +17,11 @@ Authors:
 Description
 -----------

-This driver implements support for the Texas Instruments ADS1015.
+This driver implements support for the Texas Instruments ADS1015 and
+ADS1115.

-This device is a 12-bit A-D converter with 4 inputs.
+ADS1015 is a 12-bit A-D converter with 4 inputs.
+ADS1115 is a 16-bit A-D converter with 4 inputs.

 The inputs can be used single ended or in certain differential 
combinations.

<<<< end of addendum >>>> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
