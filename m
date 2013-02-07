From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Feb 2013 11:03:10 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130207120310.121ee89f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Feb 2013 10:54:07 +0100 (CET), Dag Wieers wrote:
> It all looks good to me (system is mostly idle):
> 
> ----
> root ~ # i2cdump -r 0x3d-0x4b 0 0x48 b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x48, mode byte
> Probe range limited to 0x3d-0x4b.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 30:                                        XX XX XX                 XXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX                XXXXXXXXXXXX
> 
> root ~ # i2cget 0 0x48
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will read from device file /dev/i2c-0, chip address 0x48, current data
> address, using read byte.
> Continue? [Y/n]
> 0x4b
> 
> root ~ # gputemp
> 47 C
> ----

So no register in range 0x37-0x4b.

> I tried loading lm73 and lm75. Don't seem to do anything. I will compile 
> ds1621 in the next build.

The dump above rules out the DS75 and DS1621. Could be an LM73, but
then the lm73 driver would have found it. What did you try before
coming to the conclusion that it "don't seem to do anything"?

Next thing you can try is:

# i2cdump -r 0-0x3f 0 0x48 b

And then as usual:

# i2cget 0 0x48

> Thanks for your persistence ;-)

You're welcome.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
