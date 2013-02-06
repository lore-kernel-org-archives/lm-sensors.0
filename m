From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Feb 2013 07:08:20 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130206080820.0676cb05@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Dag,

On Wed, 6 Feb 2013 00:26:06 +0100 (CET), Dag Wieers wrote:
> I noticed on my second AppleTV device that it has a second address that 
> replied:
> 
> root ~ # i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> The differences between both devices is that this one has the original 
> wireless device (b43) instead of the crystalhd mini-pci, and it doesn't 
> have the DVB USB stick inserted.
> 
> What could 48 be ?

This address was commonly used for simple temperature sensors (e.g.
LM75) but these are no longer so frequent. This could be virtually
anything. If you are willing to take the risk, you can provide a byte
dump of the chip with:
# i2cdump 0 0x48 b
at which point I can tell you if this is a device I recognize (a.k.a.
human version of sensors-detect.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
