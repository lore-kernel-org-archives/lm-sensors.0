From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: AD7418 support
Message-Id: <20040909084544.M53051@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
In-Reply-To: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Thu, 9 Sep 2004 08:42:22 +0200, Togg wrote
> I have a Gateworks Avila Platform (IXP425 Xscale) with an AD7418
> Voltage/Temperature Sensor (Datasheet:
> http://www.analog.com/UploadedFiles/Data_Sheets/5632736AD7416_7_8_g.pdf)
>
> I didn't found any driver anywhere, so I wonder how difficult it
> would be to implement a driver. On my platform the chip is connected
> via I2C, base address 0x29. Voltages should be multiplied by 23.1

On Thu, 9 Sep 2004 10:20:46 +0100, Jean Delvare wrote
> We don't support this family of chips yet. However, these chips look 
> rather simple and writing a driver for them should be straightforward.

Hm, I guess I spoke too fast. These chips are not that simple. At a given
time, they are updating only one of their measurement channels (either the
temperature or one of the voltages). This means that the driver would have to
change channels by itself, making it "active". By contrast, all our drivers so
far (except the gl518sm in for 2.4) are passive (i.e. they only run at init
time and then when one reads from/writes to /proc or /sys). Another
possibility is to insert delays when reading the values. After all, there are
only up to 5 (AD7417) or 2 (AD7418) channels, so it shouldn't be too long.
Conversion times are 30us for the temperature channel, 15us for the voltage
channels.

I'd also have a few questions:

1* The datasheet says that the AD7418 has its address hardcoded to 0x28. You
pretend yours is at 0x29. Are you sure it is an AD7418, and not an AD7417 (or
yet another chip)?

2* How should voltages be multiplied by 23.1? The datasheet says the 10-bit
ADC has a 2.5V range. This means a LSB of 2.44mV, not 23.1mV.

As a side note, it looks like the AD7416/7/8 are mostly LM75-compatible for
the temperature part. So, providing you don't care too much about the extra
resolution bit, and you force the chip address, you should at least have
temperature readings out of the box.

-- 
Jean Delvare
http://khali.linux-fr.org/
