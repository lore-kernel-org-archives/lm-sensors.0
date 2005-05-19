From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <1088698503.2862.80.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2004-07-01 at 17:45, Jean Delvare wrote:

> BTW, d15 on lm75 is sign as well. And what's the point in lm77's having
> 4 bit for sign? If that means that all 4 bits will always be the same,
> that's something we can use for identification.

The high 4 bits can easily be the same for the LM75, too...

> >Maybe we could check for the existence T_high and T_low registers?

> We cannot. LM75 chips will not answer with an error if you try to read
> these registers. It will return a value, just that this value isn't
> relevant. I cannot remember exactly what it returns... Possible the
> value of register 0x03.

I see. Maybe writing could tell us more (write then read back and
compare) but that can be dangerous obviously.

> What we may use OTOH are:
> * unused bits in config register if they differ;

The config register is 0x0 at me by default. Don't know anything about
the LM75 though.

> * unused bits in temperature registers; they differ, and it should be
> sufficent since it's VERY unlikely that ALL 4 low bits of all
> temperature values are 0 on a LM77 (while the same bits will read 0 on a
> LM75). That should be a good thing to start with;

I'm not sure if it's really that unlikely. Some examples: 8, 16, 24,
32 (!), 40 degrees... 

> Apart from the fact that you are not interested, will you have the
> possibility to test things like sensors-detect (perl script) or i2cdump
> on the box?

Yeah, I'd be glad to help.

Thanks,
Andras

