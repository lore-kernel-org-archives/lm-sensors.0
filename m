From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 03 Dec 2013 22:20:36 +0000
Subject: Re: [lm-sensors] MotherBoard Asus A55M-E
Message-Id: <529E5934.3020602@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040009010906020409090207"
List-Id: <lm-sensors.vger.kernel.org>
References: <529E3E56.3020804@yahoo.it>
In-Reply-To: <529E3E56.3020804@yahoo.it>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040009010906020409090207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8603
>      (logical device 4 has address 0x290, could be sensors)

There is a preliminary patch supporting this driver:

> http://khali.linux-fr.org/devel/linux-3/jdelvare-hwmon/hwmon-it87-01-add-it8603e-support.patch
> Please let me know if I got anything wrong. Retesting would be
> appreciated, just in case.
>
> I have also made the support available as a standalone driver which
> builds at least down to kernel 3.0:
> http://khali.linux-fr.org/devel/lm-sensors/drivers/it87/

Please note there is a (small) problem which will be fixed soonish. If you like 
to try it out, apply attached patch on above patch or on the standalone driver.

You can also wait until it is fixed and released in next kernel version.

Thanks
Rudolf



--------------040009010906020409090207
Content-Type: text/x-diff;
 name="fixit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fixit.patch"

Index: linux-3.12/drivers/hwmon/it87.c
===================================================================
--- linux-3.12.orig/drivers/hwmon/it87.c	2013-11-22 21:57:37.454212898 +0100
+++ linux-3.12/drivers/hwmon/it87.c	2013-12-03 23:18:27.597718677 +0100
@@ -1568,6 +1568,7 @@
 	&sensor_dev_attr_in5_beep.dev_attr.attr,
 	&sensor_dev_attr_in6_beep.dev_attr.attr,
 	&sensor_dev_attr_in7_beep.dev_attr.attr,
+	NULL,
 	NULL
 };
 

--------------040009010906020409090207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040009010906020409090207--
