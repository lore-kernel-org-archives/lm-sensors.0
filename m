From: anthonyp@lantronix.com (Anthony Petillo)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: I am developing a driver for MAX6900 (RTC chip)
Message-Id: <603BA0CFF3788E46A0DB0918D9AA95100568E139@sj580004wcom.int.lantronix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
In-Reply-To: <603BA0CFF3788E46A0DB0918D9AA9510943CFD@sj580004wcom.int.lantronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you!

just to let you know, its okay to put my name on the new drivers list: Anthony Petillo
and can you please put me on the mailing list.

I will be developing the driver for Linux kernel version 2.4 only.

Thanks again.

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Friday, March 05, 2004 4:01 PM
To: Anthony Petillo
Cc: sensors@Stimpy.netroedge.com
Subject: Re: I am developing a driver for MAX6900 (RTC chip)


OK, here is your ID:

#define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/

BTW, do you intend to write your driver for Linux 2.4, 2.6, or both?

> I am also trying to find a driver for AD7414 (temperature sensor with
> 5 registers). I have looked at the DS75, LM75, ADM1021A datasheets and
> they are all different enough that it looks as though I need to write
> a driver for the AD7414 as well. There are so many drivers, does
> anyone know if there is one that I can use for the AD7414 instead of
> writing one?

I reviewed our drivers and none is compatible as far as I can see. The
nearest driver is lm75.c though. Almost similar, but different.

Writing a driver for the AD7414 and AD7415 should be easy. These are
very simple devices as far as I can see. I will assist you on request,
but I'd bet that you won't need much help, if any at all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
