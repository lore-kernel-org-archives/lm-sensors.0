From: Dag Wieers <dag@wieers.com>
Date: Tue, 05 Feb 2013 11:10:05 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302051201420.2736@pikachu.3ti.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Feb 2013, Jean Delvare wrote:

> Do you have any reason to believe that there is an SMBus-based hardware
> monitoring chip on this system?

No I haven't. In fact I would be surprised if there was one (given how 
Apple stripped the device), but I wanted to make sure that we're using all 
the capabilities of the system (and I wasn't sure if anyone went through 
the trouble already for this device).

Since the device has no power button and little ACPI functionality, it 
would have been helpful to measure temperature and voltage so we could 
determine whether changes to xbmc or the kernel improve the situation or 
makes it worse.

From the other i2c devices, the only one that returns any info is:

root ~ # ./i2cdetect -l
i2c-0   smbus           SMBus I801 adapter at efa0              SMBus adapter
i2c-1   i2c             Afatech AF9015 reference design         I2C adapter
i2c-2   i2c             NVIDIA i2c adapter 1 at 1:00.0          I2C adapter
i2c-3   i2c             NVIDIA i2c adapter 2 at 1:00.0          I2C adapter


Not sure what this output provides us with:

root ~ # ./i2cdetect 2
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-2.
I will probe address range 0x03-0x77.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Thanks for your insights,
-- 
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
