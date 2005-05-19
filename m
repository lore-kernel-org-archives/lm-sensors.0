From: togg@togg.de (Togg)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: AW: AW: AD7418 support
Message-Id: <E1C5Mbn-00038X-00@mrelayng.kundenserver.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
In-Reply-To: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I allready got RTC and EEPROM already work with 2.4. this was relatively
easy work. I2cdetect is a good starting point, thank you for the hints. 

I'll post the driver when its done.

Regards

-----Urspr?ngliche Nachricht-----
Von: Jean Delvare [mailto:khali@linux-fr.org] 
Gesendet: Donnerstag, 9. September 2004 13:23
An: Togg
Cc: sensors@Stimpy.netroedge.com
Betreff: Re: AW: AD7418 support

On Thu, 9 Sep 2004 11:18:30 +0200, Togg wrote
> I just took my information from the manual:
> http://www.gateworks.com/manuals/avila_man.pdf

Oh, I see.

BTW, you will also need a bus driver. I think that there is a driver for
some
Intel IXP series in the latest 2.6 kernels. Care to give it a try? You
should
then be able to scan the bus using i2cdetect. This would confirm the address
of the monitoring chip. According to the docs you should also find an eeprom
and a real-time clock on the I2C bus.

-- 
Jean Delvare
http://khali.linux-fr.org/

