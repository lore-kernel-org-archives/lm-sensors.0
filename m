From: ok@artecdesign.ee (Olav Kongas)
Date: Fri, 20 May 2005 10:24:28 +0000
Subject: [lm-sensors] smbus RTC as misc device
Message-Id: <Pine.LNX.4.62.0505201105290.31690@pcx>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I hope this is the right list for my question. If not, 
please point me to a better list.

Sometime at 2.6.8-2.6.9 kernel I needed a driver for the 
m41t11 RTC smbus chip. As there was none in the kernel at 
that time, I wrote it myself and made it available for user 
space as a misc device /dev/rtc (character dev 10 135). This 
way unmodified hwclock could access it. 

Now I noticed that latest kernels already contain the 
m41t00.c, which may well be able to drive my m41t11 RTC 
unmodified. However, it does not make the device available 
through /dev/rtc. Neither do that other few i2c RTCs 
currently in the kernel. They all seem to define their own 
ioctls each.

What about making i2c RTCs available through /dev/rtc 
supporting its ioctls? If this would be OK then I can 
propose a patch for m41t00.c.

Olav

!! I'm not subscribed, please CC.
