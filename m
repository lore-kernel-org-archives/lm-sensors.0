From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 13 Jun 2007 17:52:16 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-pre] s/SENSORS_/HWMON_/  in Kconfig,
Message-Id: <46702ED0.1030509@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080907040108080009040708"
List-Id: <lm-sensors.vger.kernel.org>
References: <466E2E83.4010203@gmail.com>
In-Reply-To: <466E2E83.4010203@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907040108080009040708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Mark, Hi Jim,
>
> On Tue, 12 Jun 2007 07:23:46 -0400, Mark M. Hoffman wrote:
>   
>> Hi Jim:
>>
>> * Jim Cromie <jim.cromie@gmail.com> [2007-06-11 23:26:27 -0600]:
>>     
>>> (patch attached, with this stuff at the top - hope thats ok)
>>>
>>> This changes SENSORS to HWMON in Kconfig and Makefile,
>>> which makes it agree with 'menuconfig HWMON' at the top of Kconfig,
>>> and with the dir-name itself.  ISTM that theres no reason
>>> (save legacy) to keep this arbitrary difference.
>>>       
>> It will break 'make oldconfig', although I don't care *too* much about that.
>> Does anyone else care one way or the other?
>>     

I guess I should have pointed that out.
It did give me a chance to say 'm' to all of them..


> However, if we do that, let's do it completely and clean up the
> occurrences of CONFIG_SENSORS_* that are left under drivers/i2c/chips
> at the same time. Otherwise some confusion will be left. Jim, can you
> please submit a new patch doing this?
>
> Thanks,
>   

attached, with patch-desc and sign-off at the top of the file.
I went with a separate patch since its a different subdir.

thanks.



PS - ( I wanted to say this without adding a separate 'me-too' email )

Congrats to Jean, for having successfully passed on the burden,
youve earned some laurel-resting.

And condolences to Mark, for having been talked into taking the burden.

And of course, *big thanks* to both of you, for doing this demanding,
tedious, and mostly under-appreciated job.



Mark, 
do you plan to keep web-page like Jean did with this ?

    http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/

I found it useful to avoid asking  "are we there yet ?" type questions  :-)



--------------080907040108080009040708
Content-Type: text/plain;
 name="diff.conf-sensors-2-i2c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.conf-sensors-2-i2c"


This changes SENSORS to I2C in Kconfig and Makefile which reflects
the split of drivers into the hwmon and i2c directories.

Signed-off-by:	Jim Cromie <jim.cromie@gmail.com>
---
diffstat diff.conf-sensors-2-i2c
 Kconfig  |   16 ++++++++--------
 Makefile |   16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

---

diff -ruNp -X dontdiff -X exclude-diffs sym-1/drivers/i2c/chips/Kconfig sym-2/drivers/i2c/chips/Kconfig
--- sym-1/drivers/i2c/chips/Kconfig	2007-06-13 09:49:45.000000000 -0600
+++ sym-2/drivers/i2c/chips/Kconfig	2007-06-13 11:16:23.000000000 -0600
@@ -4,7 +4,7 @@
 
 menu "Miscellaneous I2C Chip support"
 
-config SENSORS_DS1337
+config I2C_DS1337
 	tristate "Dallas Semiconductor DS1337 and DS1339 Real Time Clock"
 	depends on EXPERIMENTAL
 	help
@@ -14,7 +14,7 @@ config SENSORS_DS1337
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1337.
 
-config SENSORS_DS1374
+config I2C_DS1374
 	tristate "Maxim/Dallas Semiconductor DS1374 Real Time Clock"
 	depends on EXPERIMENTAL
 	help
@@ -24,7 +24,7 @@ config SENSORS_DS1374
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1374.
 
-config SENSORS_EEPROM
+config I2C_EEPROM
 	tristate "EEPROM reader"
 	depends on EXPERIMENTAL
 	help
@@ -35,7 +35,7 @@ config SENSORS_EEPROM
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
 
-config SENSORS_PCF8574
+config I2C_PCF8574
 	tristate "Philips PCF8574 and PCF8574A"
 	depends on EXPERIMENTAL
 	default n
@@ -49,7 +49,7 @@ config SENSORS_PCF8574
 	  These devices are hard to detect and rarely found on mainstream
 	  hardware.  If unsure, say N.
 
-config SENSORS_PCA9539
+config I2C_PCA9539
 	tristate "Philips PCA9539 16-bit I/O port"
 	depends on EXPERIMENTAL
 	help
@@ -59,7 +59,7 @@ config SENSORS_PCA9539
 	  This driver can also be built as a module.  If so, the module
 	  will be called pca9539.
 
-config SENSORS_PCF8591
+config I2C_PCF8591
 	tristate "Philips PCF8591"
 	depends on EXPERIMENTAL
 	default n
@@ -100,7 +100,7 @@ config TPS65010
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65010.
 
-config SENSORS_M41T00
+config I2C_M41T00
 	tristate "ST M41T00 RTC chip"
 	depends on PPC32
 	help
@@ -109,7 +109,7 @@ config SENSORS_M41T00
 	  This driver can also be built as a module.  If so, the module
 	  will be called m41t00.
 
-config SENSORS_MAX6875
+config I2C_MAX6875
 	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on EXPERIMENTAL
 	help
diff -ruNp -X dontdiff -X exclude-diffs sym-1/drivers/i2c/chips/Makefile sym-2/drivers/i2c/chips/Makefile
--- sym-1/drivers/i2c/chips/Makefile	2007-02-04 11:44:54.000000000 -0700
+++ sym-2/drivers/i2c/chips/Makefile	2007-06-13 11:16:17.000000000 -0600
@@ -2,14 +2,14 @@
 # Makefile for miscellaneous I2C chip drivers.
 #
 
-obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
-obj-$(CONFIG_SENSORS_DS1374)	+= ds1374.o
-obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
-obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
-obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
-obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
-obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
-obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
+obj-$(CONFIG_I2C_DS1337)	+= ds1337.o
+obj-$(CONFIG_I2C_DS1374)	+= ds1374.o
+obj-$(CONFIG_I2C_EEPROM)	+= eeprom.o
+obj-$(CONFIG_I2C_MAX6875)	+= max6875.o
+obj-$(CONFIG_I2C_M41T00)	+= m41t00.o
+obj-$(CONFIG_I2C_PCA9539)	+= pca9539.o
+obj-$(CONFIG_I2C_PCF8574)	+= pcf8574.o
+obj-$(CONFIG_I2C_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 

--------------080907040108080009040708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080907040108080009040708--
