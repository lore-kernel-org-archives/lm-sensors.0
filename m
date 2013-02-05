From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Feb 2013 11:34:02 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130205123402.1af03e75@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Feb 2013 12:10:05 +0100 (CET), Dag Wieers wrote:
> root ~ # ./i2cdetect -l
> i2c-0   smbus           SMBus I801 adapter at efa0              SMBus adapter
> i2c-1   i2c             Afatech AF9015 reference design         I2C adapter
> i2c-2   i2c             NVIDIA i2c adapter 1 at 1:00.0          I2C adapter
> i2c-3   i2c             NVIDIA i2c adapter 2 at 1:00.0          I2C adapter
> 
> 
> Not sure what this output provides us with:
> 
> root ~ # ./i2cdetect 2
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-2.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --

At 0x50 is the EDID EEPROM inside the monitor connected to the graphics
card (over the video cable.) No idea about 0x37 and 0x3a, but these
have to be chips related to the graphics card, like a video encoder if
the card has video-out.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
