From: alfred steele <alfred.jaquez@gmail.com>
Date: Wed, 15 Jul 2009 15:46:27 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <528f13590907150846o7f4e41daw4cd6e37ff3afef70@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <4A5CB908.4060404@cam.ac.uk>
	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
	 <4A5D6C0A.7030903@gmx.de>
	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>
	 <4A5DEB12.3020602@cam.ac.uk>
In-Reply-To: <4A5DEB12.3020602-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Thanks Jonathan!

> On an embedded board this would typically be in the board config
> file. =A0For example, see arch/arm/mach-pxa/imote2.c which has an sht15
> attached. =A0The exact method of registration may be a bit architecture
> specific but will look something like the relevant parts of that file.
Yep, for e.g we have wrappers for api's like gpio_request etc.
The real problem, however, seems to be that we have been using a
distro which uses kernel 2.6.24.
It does not have the "<linux/gpio.h>" and  the "<regulater/consumer.h>
 which export
regulator_register_notifier()/regulator_unregister_notifier() functions.
So, i will have to look into how to backport this. THe gpio lib thing
may be straightforward but i am way ignorant on  the regulator/pmic
infrastructure. It would greatly help you can shed some light on the
regulator part and if there is any quick way to get around to backport
the regulator specific functions.
Thanks in advance for your help!
-Alfred.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
