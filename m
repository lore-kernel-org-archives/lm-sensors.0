From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Jan 2010 16:54:09 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <20100113175409.6ba3f551@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100113153747.1dab14c5@hyperion.delvare>
In-Reply-To: <20100113153747.1dab14c5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Jan 2010 17:31:42 +0100, Manuel Lamotte-Schubert wrote:
> Here's the output.
> 
> # i2cdump 0 0x4c b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x4c, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 2d 37 80 01 08 46 d8 46 d8 ff ff ff ff ff ff ff    -7???F?F?.......
> 10: 00 00 00 00 00 00 00 04 00 6e 6e 46 d8 00 00 ff    .......?.nnF?...
> 20: 55 0a ff ff 7f e0 ff ff ff ff ff ff ff ff ff ff    U?..??..........
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: 00 00 00 84 84 84 00 00 55 00 00 ff ff ff ff ff    ...???..U.......
> f0: 08 00 00 00 84 00 00 36 80 fc 36 83 37 ff 5c 11    ?...?..6??6?7.\?
> 
> > I hoped that someone would send
> > me a board with this chip, so that I could work on it, but it did not
> > happen. If you send me a dump of your chip, I can give it a try.
> What do you need else for working on it except the board itself? Would an
> account on my machine be sufficient? What command do you need to run?

If you can rebuild a kernel with a patch applied, then you should be
able to do the tests for me. I'll post a patch in a few minutes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
