From: etienne_lorrain@yahoo.fr (Etienne Lorrain)
Date: Mon, 20 Mar 2006 23:00:37 +0000
Subject: [lm-sensors] sis96x compiled in by error: delay of one minute
Message-Id: <20060320230037.29764.qmail@web26902.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20060317042019.GC3446@jupiter.solarsys.private>
References: <20060316035916.GA10675@jupiter.solarsys.private>
In-Reply-To: <20060316035916.GA10675@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

--- "Mark M. Hoffman" wrote:
> * Etienne Lorrain [2006-03-16 11:53:32 +0100]:
> >  I did not built with all hwmon drivers because I could determine what I
> >  had on my mainboard.
> 
> Really?  If you don't have all the hwmon drivers built in, then I'm not
> sure how the i2c subsystem could take so long to init.  Can we see the
> entire kernel config please?

   That is the real 2.6.16 with only CONFIG_I2C_VIAPRO=y (the only I2C module loaded
 using Knoppix on my motherboard) (full .config attached):

Mar 20 22:12:34 ubuntu kernel: [  102.107512] input: PC Speaker as /class/input/input2
Mar 20 22:12:34 ubuntu kernel: [  102.110230] i2c /dev entries driver
Mar 20 22:12:34 ubuntu kernel: [  102.151923]  : Detection failed at step 3
Mar 20 22:12:34 ubuntu kernel: [  102.287882] hdaps: supported laptop not found!
Mar 20 22:12:34 ubuntu kernel: [  102.290460] hdaps: driver init failed (ret=-6)!
Mar 20 22:12:34 ubuntu kernel: [  102.299862] md: linear personality registered for level
-1

etienne at ubuntu:~/linux/linux-2.6.16$ diff .config-initial .config
4c4
< # Mon Mar 20 21:36:32 2006
---
> # Mon Mar 20 22:03:44 2006
885c885
< # CONFIG_I2C_PCA_ISA is not set
---
> CONFIG_I2C_PCA_ISA=y
892c892
< # CONFIG_SENSORS_EEPROM is not set
---
> CONFIG_SENSORS_EEPROM=y
896c896
< # CONFIG_SENSORS_RTC8564 is not set
---
> CONFIG_SENSORS_RTC8564=y
etienne at ubuntu:~/linux/linux-2.6.16$

  Leads to 21 seconds delay:

Mar 20 22:16:34 ubuntu kernel: [   47.768105] drivers/usb/input/hid-core.c: v2.6:USB HID
core driver
Mar 20 22:16:34 ubuntu kernel: [   47.770813] usbcore: registered new driver microtekX6
Mar 20 22:16:34 ubuntu kernel: [   47.773540] mice: PS/2 mouse device common for all mice
Mar 20 22:16:34 ubuntu kernel: [   47.822537] input: AT Translated Set 2 keyboard as
/class/input/input1
Mar 20 22:16:34 ubuntu kernel: [   47.825434] input: PC Speaker as /class/input/input2
Mar 20 22:16:34 ubuntu kernel: [   47.828153] i2c /dev entries driver
Mar 20 22:16:34 ubuntu kernel: [   47.831032] i2c-pca-isa: i/o base 0x000330. irq 10
Mar 20 22:16:34 ubuntu kernel: [   68.239670]  : Detection failed at step 3
Mar 20 22:16:34 ubuntu kernel: [   68.375633] hdaps: supported laptop not found!
Mar 20 22:16:34 ubuntu kernel: [   68.378227] hdaps: driver init failed (ret=-6)!
Mar 20 22:16:34 ubuntu kernel: [   68.387599] md: linear personality registered for level
-1

BTW, someone knows what are those messages just after startup:

Mar 20 22:12:34 ubuntu kernel: No module symbols loaded - kernel modules not enabled.
Mar 20 22:12:34 ubuntu kernel: >[   93.075610] pass
Mar 20 22:12:34 ubuntu kernel: [   93.075649] test 4:
Mar 20 22:12:34 ubuntu kernel: [   93.075692] 697eaf0aca3a3aea3a75164746ffaa79
Mar 20 22:12:34 ubuntu kernel: [   93.076226] pass
Mar 20 22:12:34 ubuntu kernel: [   93.076266] test 5:
Mar 20 22:12:34 ubuntu kernel: [   93.076309] 56461ef2342edc00f9bab995690efd4c
Mar 20 22:12:34 ubuntu kernel: [   93.076857] pass
Mar 20 22:12:34 ubuntu kernel: [   93.076896] test 6:
Mar 20 22:12:34 ubuntu kernel: [   93.076941] 6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
Mar 20 22:12:34 ubuntu kernel: [   93.077475] pass
Mar 20 22:12:34 ubuntu kernel: [   93.077514] test 7:
Mar 20 22:12:34 ubuntu kernel: [   93.077559] 6f630fad67cda0ee1fb1f562db3aa53e
Mar 20 22:12:34 ubuntu kernel: [   93.078093] pass
Mar 20 22:12:34 ubuntu kernel: [   93.078133]
Mar 20 22:12:34 ubuntu kernel: [   93.078134] testing hmac_md5 across pages
Mar 20 22:12:34 ubuntu kernel: [   93.078269] test 1:
Mar 20 22:12:34 ubuntu kernel: [   93.078314] 750c783e6ab0b503eaa86e310a5db738
Mar 20 22:12:34 ubuntu kernel: [   93.078848] pass
Mar 20 22:12:34 ubuntu kernel: [   93.078889]
Mar 20 22:12:34 ubuntu kernel: [   93.078890] testing hmac_sha1
Mar 20 22:12:34 ubuntu kernel: [   93.078973] test 1:
Mar 20 22:12:34 ubuntu kernel: [   93.079020] b617318655057264e28bc0b6fb378c8ef146be00
Mar 20 22:12:34 ubuntu kernel: [   93.079678] pass
Mar 20 22:12:34 ubuntu kernel: [   93.079717] test 2:
Mar 20 22:12:34 ubuntu kernel: [   93.079762] effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Mar 20 22:12:34 ubuntu kernel: [   93.080432] pass
Mar 20 22:12:34 ubuntu kernel: [   93.080472] test 3:
Mar 20 22:12:34 ubuntu kernel: [   93.080517] 125d7342b9ac11cd91a39af48aa17b4f63f175d3
Mar 20 22:12:34 ubuntu kernel: [   93.081175] pass
Mar 20 22:12:34 ubuntu kernel: [   93.081214] test 4:
Mar 20 22:12:34 ubuntu kernel: [   93.081260] 4c9007f4026250c6bc8414f9bf50c86c2d7235da
Mar 20 22:12:34 ubuntu kernel: [   93.081917] pass
Mar 20 22:12:34 ubuntu kernel: [   93.081957] test 5:
Mar 20 22:12:34 ubuntu kernel: [   93.082649] 4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
Mar 20 22:12:34 ubuntu kernel: [   93.083307] pass
Mar 20 22:12:34 ubuntu kernel: [   93.083347] test 6:
Mar 20 22:12:34 ubuntu kernel: [   93.083394] aa4ae5e15272d00e95705637ce8a3b55ed402112
Mar 20 22:12:34 ubuntu kernel: [   93.084051] pass
Mar 20 22:12:34 ubuntu kernel: [   93.084090] test 7:
Mar 20 22:12:34 ubuntu kernel: [   93.084138] e8e99d0f45237d786d6bbaa7965c7808bbff1a91
Mar 20 22:12:34 ubuntu kernel: [   93.084808] pass
Mar 20 22:12:34 ubuntu kernel: [   93.084848]
Mar 20 22:12:34 ubuntu kernel: [   93.084849] testing hmac_sha1 across pages
Mar 20 22:12:34 ubuntu kernel: [   93.084936] test 1:
Mar 20 22:12:34 ubuntu kernel: [   93.084981] effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Mar 20 22:12:34 ubuntu kernel: [   93.085639] pass
Mar 20 22:12:34 ubuntu kernel: [   93.085681]

  Regards,
  Etienne.


	

	
		
___________________________________________________________________________ 
Nouveau : t?l?phonez moins cher avec Yahoo! Messenger ! D?couvez les tarifs exceptionnels pour appeler la France et l'international.
T?l?chargez sur http://fr.messenger.yahoo.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config-initial
Type: application/octet-stream
Size: 34511 bytes
Desc: 276185620-.config-initial
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060321/eff20ec6/config-initial-0001.obj
