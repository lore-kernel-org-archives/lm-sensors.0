From: togg@togg.de (Togg)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: AD7418 support
Message-Id: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a Gateworks Avila Platform (IXP425 Xscale) with an AD7418
Voltage/Temperature Sensor (Datasheet:
http://www.analog.com/UploadedFiles/Data_Sheets/5632736AD7416_7_8_g.pdf)

I didn't found any driver anywhere, so I wonder how difficult it would be to
implement a driver. On my platform the chip is connected via I2C, base
address 0x29. Voltages should be multiplied by 23.1 

I don't have any experience on writing I2C drivers. Anyone knows if there
are good reference drivers which could be used? Best solution for me would
be if someone would implement this in a free minute :)

Regards,
Togg

Btw: I am not on this mailinglist, so please CC me directly.

