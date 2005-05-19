From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <20040413114824.6a8f03fd.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Apr 2004 11:56:16 -0700
Eugene Surovegin <ebs@ebshome.net> wrote:

> On Mon, Apr 12, 2004 at 10:41:43PM +0400, Evgeniy Polyakov wrote:
> > > Well, this doesn't look correct.
> > > Could you explain what are you trying to do? Also, why did you
> > > change debugging macros?
> > 
> > Because they don't even compile with debug level > 0.
> 
> Huh? I don't have any problems here (gcc 2.95.3).

powerpc-405-linux-gnu-gcc (GCC) 3.3.2

i2c-ibm_iic.c:105:35: pasting ""ibm-iic"" and ""%d: init\n"" does not
give a valid preprocessing token i2c-ibm_iic.c:152:41: pasting
""ibm-iic"" and ""%d: soft reset\n"" does not give a valid preprocessing
token i2c-ibm_iic.c:161:67: pasting ""ibm-iic"" and ""%d: trying to
regain bus control\n"" does not give a valid preprocessing token
i2c-ibm_iic.c:201:59: pasting ""ibm-iic"" and ""%d: irq handler, STS 0x%02x, EXTSTS = 0x%02x\n"" does not give a valid preprocessing token
i2c-ibm_iic.c:218:43: pasting ""ibm-iic"" and ""%d: xfer error, EXTSTS 0x%02x\n"" does not give a valid preprocessing token
i2c-ibm_iic.c:233:70: pasting ""ibm-iic"" and ""%d: bus is stuck,
resetting\n"" does not give a valid preprocessing token
..


> > 
> > > Chip doesn't support 0-length transactions, and your code trying
> > > to start 1-byte transaction without writing any data to the output
> > > FIFO.
> > 
> > It does support although not fair.
> 
> No, it doesn't. Please read any 4xx IBM manual. 
> Your code starts 1-byte _write_ transaction with whatever crap was in
> output FIFO. You clear TCT field in IICx_CNTL, and it means _1_byte_
> will be transfered _after_ i2c address.

But this generates irq on ACK and driver can catch this.
It is correct behaviour but yes it costs something.

> This is not correct and this is not safe.
> 
> > I have tested with this (as you say) "hack" max663x chip.
> 
> So what? You are lucky and it "works" with you particular chip, it
> doesn't mean it'll work with another. I have a board here where even
> 1-byte _read_ access locks the bus completely (device is write-only
> clock driver).

It works always.
You just writes something to something. It is quite normal behaviour for
write enabled devices.
Actually those transaction is terminated by the others.
HMT should be set to 1.

> > > IBM IIC is broken enough and I don't see any point in such hacks.
> > 
> > Agree. But it is not point not to fixing at least initialization at
> > least in such manner.
> 
> What _initialization_ are you talking about? I'm using this driver on
> several different custom boards in production systems.

i2c layer uses SMBUS_QUICK mode to find devices on the bus.
With current ibm iic driver it always succeeds no matter is device there
or not.

> > > There is another patch I made for MV guys a month ago 
> > > (http://kernel.ebshome.net/iic_0_len-2.4.diff, 
> > > http://kernel.ebshome.net/iic_0_len-2.6.diff). 
> > > 
> > > It restores _incorrect_ old driver behavior and most probably I'll
> > > send that version upstream (I'm still waiting for OK from them).
> > 
> > Driver with your patch works exactly as driver without it.
> 
> No, with my patch driver will not initiate any _unsafe_ operation on
> the bus like in your case.
>
> > It always returns 0 with or without any ACK read from bus.
> > It is wrong.
> 
> Yes, but the _only_ correct way I see of implementing 0-length
> transactions is bit-banging, for the time being I choose to just
> implement the _old_ _driver__behavior_ until somebody shows me that
> there is a problem with this approach.
> 
> IMHO all this _auto_ detection stuff is one big hack, I don't see
> _any_ provisions for this in i2c specs. 

Agree.
Probably better idea to implement autodetection method in adapter's
driver itself and provide it to generic i2c layer and call it only when
it is presented and proven to be safe.

Actually we have following situation:
1. Do not use autodetection mechanism, forcing inserting and so forth.
2. Use some kind of "hacks" to emulate i2c layer autoprobing with
0-length transactions when it is safe to do.

Your approach uses first, mine - second.

> 
> Eugene.


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
