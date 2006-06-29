From: be.terawatt@laposte.net (Matthieu TORRES)
Date: Thu, 29 Jun 2006 07:06:54 +0000
Subject: [lm-sensors] RTC + DS1337
Message-Id: <44A37C0E.3090604@laposte.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I faced a problem with DS1337 RTC.  I use a pxa255 cpu with 2.6.16 
kernel. I tried to make a DS1339 chip (real time clock) working with 
hwclock.
In my config, I selected I2C, DS1337/DS1339 driver, and ehanced RTC 
support to have it working with /dev/rtc as expected by hwclock. That is 
to say the following options:

CONFIG_RTC=y
CONFIG_I2C=y
CONFIG_I2C_PXA=y
CONFIG_SENSORS_DS1337=y

The ioctl() to dev/rtc did not work. While investaigating on that issue, 
I found 2 problems :

- the option "Enhanced Real Time Clock Support" (config RTC)  does not 
provide generic access to a RTC chip via /dev/rtc as I belevied. The 
access to the chip in driver/char/rtc.c are made with CMOS_READ() and 
CMOS_WRITE(),  defined in Linux/include/asm-arm/mc146818rtc.h. It is a 
combination of outb_p() and inb_p() : no chance to access my I2C chip 
that way...
So I added ioct() support in /drivers/i2c/chips/ds1337.c.

- the driver (/drivers/i2c/chips/ds1337.c) has two problems (I'm not 
sure it is bugs, but at least on my system it does not work).
First, ds1337_detect() reads some values in the chip registers that are 
assumed to be wrong, but in my chip they do exist (I swear I have a 
DS1339). I commented out these checks.
Then, the part that enables the RTC after first power up in 
ds1337_init_client() fails to write a status bit in the chip, so we fall 
into the same reset code (that writes zeros in the RTC regs) after each 
reboot.
I corrected this and that's OK for me.

I can post code if it is usefull for someone.


