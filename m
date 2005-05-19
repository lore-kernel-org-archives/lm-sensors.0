From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: AD7418 support
Message-Id: <20040909082035.M49081@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
In-Reply-To: <E1C5IdT-000803-00@mrelayng.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 9 Sep 2004 08:42:22 +0200, Togg wrote
> I have a Gateworks Avila Platform (IXP425 Xscale) with an AD7418
> Voltage/Temperature Sensor (Datasheet:
> http://www.analog.com/UploadedFiles/Data_Sheets/5632736AD7416_7_8_g.pdf)
> 
> I didn't found any driver anywhere, so I wonder how difficult it 
> would be to implement a driver. On my platform the chip is connected 
> via I2C, base address 0x29. Voltages should be multiplied by 23.1

We don't support this family of chips yet. However, these chips look rather
simple and writing a driver for them should be straightforward.

> I don't have any experience on writing I2C drivers. Anyone knows if there
> are good reference drivers which could be used? Best solution for me 
> would be if someone would implement this in a free minute :)

I think you could start from the adm1025 driver for the general structure. The
AD7416/7/8 have some 16-bit registers, you could take a look at the lm75
driver for how this should be handled.

A single driver should support the three chips. However, until we actually
meet an AD7416 or an AD7417, supporting only the AD7418 is fine.

We have a document explaining how one can write a driver to support a new chip:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/new_drivers
This is for 2.4. For 2.6 there is a porting guide in the kernel sources:
Documentation/i2c/porting-clients

Good luck.

-- 
Jean Delvare
http://khali.linux-fr.org/
