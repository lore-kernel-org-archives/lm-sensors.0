From: alfred steele <alfred.jaquez@gmail.com>
Date: Thu, 16 Jul 2009 16:13:34 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <528f13590907160913n73dcb4fcuf09f4946d7578793@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <4A5CB908.4060404@cam.ac.uk>
	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
	 <4A5D6C0A.7030903@gmx.de>
	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>
	 <4A5DEB12.3020602@cam.ac.uk>
	 <528f13590907151032y30ae62beo486d4e1056219983@mail.gmail.com>
	 <4A5E206F.8000001@cam.ac.uk>
In-Reply-To: <4A5E206F.8000001-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Hi Jonathan,
Thanks for the relentless help. I have adapted the driver to my
platform by changing the following:
gpio_request(), gpio_get/gpio_set() to thier counterparts on my platform.

> couple of mfp defines to enable the gpios. (how you do this is platform dependent)
By this i guess, you mean configuring the gpios, and defining the I/O
characteristics for each of the signals.

>mework there are some bits and bobs related

So after doing all the porting, i was able to compile it as an
loadable kernel module. I tried insmod and here;s what i get:

~$ insmod sht15.ko
regulator: Unable to get requested regulator: vcc
sht15 sht15: Command not acknowledged
 ~$
Do i have to play with any timings related to the part. I have a SHT11
, but i was assuming that there is no significant difference.
Although something may have gone wrong when i ported.
-Alfred.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
