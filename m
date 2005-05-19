From: jbs@bandos.homelinux.com (Jose Bernardo Silva)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Usbvision/i2c-algo-usb port to 2.8.0
Message-Id: <20030804132323.M54574@bandos.homelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030730165206.M58081@bandos.homelinux.com>
In-Reply-To: <20030730165206.M58081@bandos.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I picked up most from the kernel patch
(http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.21-i2c-2.8.0.patch),
in which you also leave out algo_control in your patch for i2c-algo-bit.c;

@@ -532,12 +519,9 @@
 
 static struct i2c_algorithm i2c_bit_algo = {
-	"Bit-shift algorithm",
-	I2C_ALGO_BIT,
-	bit_xfer,
-	NULL,
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+	.owner		= THIS_MODULE,
+	.name		= "Bit-shift algorithm",
+	.id		= I2C_ALGO_BIT,
+	.master_xfer	= bit_xfer,
+	.functionality	= bit_func,
 };

As this seems to work, I tried converting i2c-algo-usb.c based on this, and
even leaving out algo_control I was able to compile and use the drivers. I'll
try your new patch when I get home today (I hope),

Thanks!

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
Sent: Mon, 4 Aug 2003 14:14:00 +0200
Subject: Re: Usbvision/i2c-algo-usb port to 2.8.0

> > I finally managed to test the patch, the following (or something like
> > it) should be added:
> > 
> > --------------------------------------------------------------
> > --- /usr/src/usbvision-0.3.3-test5/src/i2c-algo-usb.c   2003-06-05
> > 10:34:26.000000000 +0100
> > +++ /usr/src/linux/drivers/usb/i2c-algo-usb.c   2003-08-03
> > 22:23:20.000000000+0100
> > @@ -182,14 +182,11 @@
> >  /* -----exported algorithm data:
> >  ------------------------------------- */
> > 
> >  static struct i2c_algorithm i2c_usb_algo = {
> > -       "USB algorithm",
> > -       I2C_ALGO_BIT,           /* FIXME */
> > -       usb_xfer,
> > -       NULL,
> > -       NULL,                   /* slave_xmit           */
> > -       NULL,                   /* slave_recv           */
> > -       algo_control,           /* ioctl                */
> > -       usb_func,               /* functionality        */
> > +       .owner          = THIS_MODULE,
> > +       .name           = "USB algorithm",
> > +       .id             = I2C_ALGO_BIT,
> > +       .master_xfer    = usb_xfer,
> > +       .functionality  = usb_func,
> >  };
> > 
> >  /*
> > --------------------------------------------------------------
> > 
> > Apart from that, it worked fine. Thanks!
> 
> You're welcome. I didn't know that the i2c_algorithm struct could
> require changes too, thanks a lot for pointing this out. I hope I didn't
> miss such changes for other drivers I have been converting, other 
> than the saa7134 which I just fixed too. Since I had been testing 
> the other drivers (use or at least compilation), I guess it's OK.
> 
> I uploaded fixed patches a few minutes ago. My fix for i2c-algo-usb 
> is slightly different, since you forgot the algo_control member. I 
> guess it wasn't intentional and fixed that too.
> 
> Thanks for reporting!
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
------- End of Original Message -------
