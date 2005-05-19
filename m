From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: Clean up of i2c-elektor.c build for 2.6.11
Message-Id: <422E2417.7020707@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

I am trying to fix some problems I am having with my 2.6.9 and trying 
some stuff with 2.6.11. I see a lot of differences with the I2C and 
almost everything I have tested works. (applause). One of the messages I 
noticed during the kernel module build of 2.6.11 was i2c-elektor.c 
complaining:

drivers/i2c/busses/i2c-elektor.c:120: warning: comparison of distinct 
pointer types lacks a cast
drivers/i2c/busses/i2c-elektor.c:127: warning: comparison of distinct 
pointer types lacks a cast
drivers/i2c/busses/i2c-elektor.c:131: warning: comparison of distinct 
pointer types lacks a cast

I traced it down to the flags type on line 115. Now it builds cleanly. I 
have tested this and it appears to have no impact on my stuff. This 
should a low priority patch item but makes it easier to spot real bugs 
when the build occurs without these messages.

Thanks
Frank


--- diff ---
i2c-elektor.c
115c115
<       long flags;
---
 >       unsigned long flags;
