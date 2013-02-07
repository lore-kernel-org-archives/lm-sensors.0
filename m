From: Dag Wieers <dag@wieers.com>
Date: Thu, 07 Feb 2013 09:54:07 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302071049590.2736@pikachu.3ti.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Feb 2013, Jean Delvare wrote:

> I would suggest the following:
> # i2cdump -r 0x3d-0x4b 0 0x48 b
>
> This should be pretty safe, as even if the chip doesn't use 8-bit
> register addressing, at least we know that values in the 0x3d-0x4b
> range are fine for your system.
>
> If this is a DS75 or DS1621 chip you should see some register values.
> If this is an LM73 you won't.
>
> Then try again:
> # i2cget 0 0x48
> If you don't get a value in the range you expect, play it safe and
> power down the machine immediately, then cold boot it.

I am trusting you blindly here ;-)

It all looks good to me (system is mostly idle):

----
root ~ # i2cdump -r 0x3d-0x4b 0 0x48 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x48, mode byte
Probe range limited to 0x3d-0x4b.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
30:                                        XX XX XX                 XXX
40: XX XX XX XX XX XX XX XX XX XX XX XX                XXXXXXXXXXXX

root ~ # i2cget 0 0x48
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will read from device file /dev/i2c-0, chip address 0x48, current data
address, using read byte.
Continue? [Y/n]
0x4b

root ~ # gputemp
47 C
----

I tried loading lm73 and lm75. Don't seem to do anything. I will compile 
ds1621 in the next build.

Thanks for your persistence ;-)
-- 
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
