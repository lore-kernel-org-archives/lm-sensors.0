From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: AW: AD7418 support
Message-Id: <20040909101939.M46105@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
In-Reply-To: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 9 Sep 2004 11:18:30 +0200, Togg wrote
> I just took my information from the manual:
> http://www.gateworks.com/manuals/avila_man.pdf

Oh, I see.

BTW, you will also need a bus driver. I think that there is a driver for some
Intel IXP series in the latest 2.6 kernels. Care to give it a try? You should
then be able to scan the bus using i2cdetect. This would confirm the address
of the monitoring chip. According to the docs you should also find an eeprom
and a real-time clock on the I2C bus.

-- 
Jean Delvare
http://khali.linux-fr.org/
