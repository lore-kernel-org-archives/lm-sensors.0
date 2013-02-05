From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Feb 2013 11:00:26 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130205120026.1c941025@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Feb 2013 11:40:50 +0100 (CET), Dag Wieers wrote:
> On Tue, 5 Feb 2013, Jean Delvare wrote:
> > # ./i2cdetect 0
> 
> root ~ # ./i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] Y
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> Anything I can read to understand the output ?

Not really. It takes some experience to interpret the results, although
the above is so simple that it should be easy.

A single chip replied to the probes, at 7-bit I2C slave address 0x69.
On computers, this address is most typically used by a clock chip. It
is advised to leave that kind of chip alone unless you know exactly
what brand and model it is and how it is connected to the other components
on the board.

To put it short: if you were looking for a hardware monitoring chip,
it's not there. Or maybe it is there but behind a multiplexer -
something which can't be detected.

Do you have any reason to believe that there is an SMBus-based hardware
monitoring chip on this system?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
