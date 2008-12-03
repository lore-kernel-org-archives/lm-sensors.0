From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 03 Dec 2008 12:19:36 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-watchdog-v4.patch
Message-Id: <49367958.5050008@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030002020301080508030100"
List-Id: <lm-sensors.vger.kernel.org>
References: <493007E2.4070101@redhat.com>
In-Reply-To: <493007E2.4070101@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030002020301080508030100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 28 Nov 2008 16:01:54 +0100, Hans de Goede wrote:
>> Hi Jean,
>>
>> Today I had access to my FSC test machine for the first time in a while. So 
>> here is the latest version of my watchdog support for Siemens hwmon IC's patch. 
>> This fixes the last 2 issues you spotted during review. Can you please queue 
>> this for 2.6.29 ? If Wim comes up with anything during his review I'll fix that 
>> with a follow up patch,
> 
> Applied, thanks. Now I'm waiting for the patch which deprecates fscher
> and fscpos :)
> 

Attached (to be applied on top of the previous 2 fschmd patches).

Regards,

Hans

--------------030002020301080508030100
Content-Type: text/plain;
 name="hwmon-fschmd-03-deprecate-pos-her.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="hwmon-fschmd-03-deprecate-pos-her.patch"

Now that the new merged fschmd driver has gained support for the watchdog
integrated into these IC's, there is no more reason to keep the old fscher and
fscpos drivers around, so mark them as depcrated.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up vanilla-2.6.28-rc7-git1/drivers/hwmon/Kconfig~ vanilla-2.6.28-rc7-git1/drivers/hwmon/Kconfig
--- vanilla-2.6.28-rc7-git1/drivers/hwmon/Kconfig~	2008-12-03 13:12:42.000000000 +0100
+++ vanilla-2.6.28-rc7-git1/drivers/hwmon/Kconfig	2008-12-03 13:12:42.000000000 +0100
@@ -304,9 +304,13 @@ config SENSORS_F75375S
 	  will be called f75375s.
 
 config SENSORS_FSCHER
-	tristate "FSC Hermes"
+	tristate "FSC Hermes (DEPRECATED)"
 	depends on X86 && I2C
 	help
+	  This driver is DEPRECATED please use the new merged fschmd
+	  ("FSC Poseidon, Scylla, Hermes, Heimdall and Heracles") driver
+	  instead.
+
 	  If you say yes here you get support for Fujitsu Siemens
 	  Computers Hermes sensor chips.
 
@@ -314,9 +318,13 @@ config SENSORS_FSCHER
 	  will be called fscher.
 
 config SENSORS_FSCPOS
-	tristate "FSC Poseidon"
+	tristate "FSC Poseidon (DEPRECATED)"
 	depends on X86 && I2C
 	help
+	  This driver is DEPRECATED please use the new merged fschmd
+	  ("FSC Poseidon, Scylla, Hermes, Heimdall and Heracles") driver
+	  instead.
+
 	  If you say yes here you get support for Fujitsu Siemens
 	  Computers Poseidon sensor chips.
 
@@ -325,15 +333,15 @@ config SENSORS_FSCPOS
 
 config SENSORS_FSCHMD
 	tristate "FSC Poseidon, Scylla, Hermes, Heimdall and Heracles"
-	depends on X86 && I2C && EXPERIMENTAL
+	depends on X86 && I2C
 	help
 	  If you say yes here you get support for various Fujitsu Siemens
 	  Computers sensor chips, including support for the integrated
 	  watchdog.
 
-	  This is a new merged driver for FSC sensor chips which is intended
-	  as a replacement for the fscpos, fscscy and fscher drivers and adds
-	  support for several other FCS sensor chips.
+	  This is a merged driver for FSC sensor chips replacing the fscpos,
+	  fscscy and fscher drivers and adding support for several other FCS
+	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called fschmd.

--------------030002020301080508030100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030002020301080508030100--
