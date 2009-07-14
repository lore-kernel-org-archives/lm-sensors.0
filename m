From: alfred steele <alfred.jaquez@gmail.com>
Date: Tue, 14 Jul 2009 20:58:03 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <4A5CB908.4060404@cam.ac.uk>
In-Reply-To: <4A5CB908.4060404-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Hi Jonathan,
Thanks!
> Worth noting at this point that there is already a driver for this chip
> in mainline (sht15 under hwmon - I've copied this to the lm-sensors where
> that driver has previously been discussed).
Oh ok, so its only in 2.6.30.So i believe i just need to adapt it to
the GPIOs used on my platform. Would it be sufficient to just populate
the GPIO no.s in the platform dev structure as the probe and remove
routine would  still remain the same for SHT1x devices

> First thing to note is that this device is in no way using an i2c type
> comms protocol. I'd be somewhat surprised if any i2c controllers are
> generic enough to talk to it. =A0The start condition is non standard,
I understand that. I meant the gpio bitbanging interface.

> it uses a 3 bit address (with only 000) supported, and it also has a
> fairly hideous means of indicating that the sampling process
> has finished. =A0Basically you'd have more luck using the gpio's directly
> than through anything to do with i2c.
But i am just pondering over the fact that if they have a bitbanging
gpio interface in the i2c subsystem, why should i not be able to just
pass the protocol header as a payload(void *data) to the interface and
design the user space driver which implements SHT11 specific
start/stop transmission sequence. Please correct me if i am wrong. I
am not sure about the "end of sampling"  indication though. I am still
going through the data sheet. To sum it up, the intention is code
reusablity in the sense that if we move to a different part which sits
on the I2c bus, we need not have to modify the kernel driver, just
keep the complexity  in the userspace.

Thanks,
Alfred.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
