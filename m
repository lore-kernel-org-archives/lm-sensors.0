From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: I am developing a driver for MAX6900 (RTC chip)
Message-Id: <4047E1B3.9080701@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
In-Reply-To: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anthony is correct, a real time clock is quite different from
the type of clock driver chip supported by icspll, and a new device ID is appropriate.
mds

Anthony Petillo wrote:
> Hi Jean,
> 
> This is what I have discovered so far, the icspll documentation and source show that the chip has to live at 0x69. The max6900 has a slave address of 0xa0. The chip looks alot like the ds1307 (minus the irq and frequency functions). I have not worked with the lm_sensors and i2c packages very long, so forgive me if I ask stupid questions. Assuming a linux kernel of version 2.4.24, I was going to use the drivers/acorn/pcf8583.c as a template, this chip has a slave address of 0x68 and the other functions that max6900 does not support. I was also going to use the acorn/i2c.c file as a guide to create my adapter and connect to the /dev/rtc device. 
> 
> Basically I think I need a new device id, but because of where I am at in learning this stuff it may not be necessary.
> 
> Jean thanks for your time, I appreciate it very much.
> 
> Anthony.
> 
> 
> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, March 02, 2004 2:19 PM
> To: Anthony Petillo
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: I am developing a driver for MAX6900 (RTC chip)
> 
> 
> 
>>Hi, my name is Anthony Petillo and I am currently working on a driver
>>for Maxim's MAX6900. It is an I2C bus compatible real-time clock and
>>contains 31 bytes of battery backed ram. 
>>
>>I was wondering if I could get a device id to add to i2c-id.h.
> 
> 
> Hi Anthony,
> 
> We have a driver for clock chips named icspll. Please take a look and
> confirm that your MAX6900 wouldn't fit in it. If not, I'll give you an
> ID.
> 
> Thanks.
> 
