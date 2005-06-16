From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 19:47:09 +0000
Subject: [lm-sensors] smbus RTC as misc device
Message-Id: <20050616194558.402b7253.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Olav,

Sorry for the delay.

> I hope this is the right list for my question. If not, 
> please point me to a better list.
> 
> Sometime at 2.6.8-2.6.9 kernel I needed a driver for the 
> m41t11 RTC smbus chip. As there was none in the kernel at 
> that time, I wrote it myself and made it available for user 
> space as a misc device /dev/rtc (character dev 10 135). This 
> way unmodified hwclock could access it. 
> 
> Now I noticed that latest kernels already contain the 
> m41t00.c, which may well be able to drive my m41t11 RTC 
> unmodified. However, it does not make the device available 
> through /dev/rtc. Neither do that other few i2c RTCs 
> currently in the kernel. They all seem to define their own 
> ioctls each.
> 
> What about making i2c RTCs available through /dev/rtc 
> supporting its ioctls? If this would be OK then I can 
> propose a patch for m41t00.c.

You are probably right. There have been quite a few discussions lately
about how to standardize the kernel interface to RTC drivers, the same
question may hold for the user-space interface.

However, this is neither related to hardware monitoring, nor to i2c, so
there's not much advice we can give to you - it's something we don't
know anything about ourselves. Better try to contact the various authors
of RTC drivers and/or the LKML, and see what they think about the idea.

-- 
Jean Delvare
