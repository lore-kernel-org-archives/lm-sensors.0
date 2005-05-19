From: jbs@bandos.homelinux.com (Jose Bernardo Silva)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Usbvision/i2c-algo-usb port to 2.8.0
Message-Id: <20030803202824.M42291@bandos.homelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030730165206.M58081@bandos.homelinux.com>
In-Reply-To: <20030730165206.M58081@bandos.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I finally managed to test the patch, the following (or something like it)
should be added:

--------------------------------------------------------------
--- /usr/src/usbvision-0.3.3-test5/src/i2c-algo-usb.c   2003-06-05
10:34:26.000000000 +0100
+++ /usr/src/linux/drivers/usb/i2c-algo-usb.c   2003-08-03 22:23:20.000000000
+0100
@@ -182,14 +182,11 @@
 /* -----exported algorithm data: ------------------------------------- */

 static struct i2c_algorithm i2c_usb_algo = {
-       "USB algorithm",
-       I2C_ALGO_BIT,           /* FIXME */
-       usb_xfer,
-       NULL,
-       NULL,                   /* slave_xmit           */
-       NULL,                   /* slave_recv           */
-       algo_control,           /* ioctl                */
-       usb_func,               /* functionality        */
+       .owner          = THIS_MODULE,
+       .name           = "USB algorithm",
+       .id             = I2C_ALGO_BIT,
+       .master_xfer    = usb_xfer,
+       .functionality  = usb_func,
 };

 /*
--------------------------------------------------------------

Apart from that, it worked fine. Thanks!

---
Jose Bernardo B R Silva             | Source Mage GNU/Linux Section Guru
jbernardo@sourcemage.org            | http://www.sourcemage.org
http://counter.li.org #245602
http://cosmos.oninetspeed.pt/jose.bernardo
jbs@bandos.homelinux.com


---------- Original Message -----------
From: Jean Delvare <khali@linux-fr.org>
To: "Jose Bernardo Silva" <jbs@bandos.homelinux.com>
Cc: sensors@Stimpy.netroedge.com
Sent: Thu, 31 Jul 2003 11:50:58 +0200
Subject: Re: Usbvision/i2c-algo-usb port to 2.8.0

> > Thanks! Will do, as soon as I can. I will also email the patch to the
> > author(s) of the usbvision drivers, after I test it, ok?
> 
> Mhh, not necessarily. The patch is intended for users, not authors. 
> If the author was to apply this patch to his code right now, users 
> that are not using i2c-2.8.0 couldn't use usbvision anymore.
> 
> Once the new I2C has made it into the official kernel (should be 
> 2.4.23) we'll submit real patches to the authors that work for both 
> pre-2.4.23 and 2.4.23 kernels.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
------- End of Original Message -------
