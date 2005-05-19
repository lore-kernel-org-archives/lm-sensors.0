From: hgchew@gunnet.org (Chew Hong Gunn)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040202173158.GA20654@evilmoon.gunnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > There is already regvalue = gl518_read_value() & 0x14;
> 
> In fact there shouldn't be. Because I believe it shouldn't be, I forgot
> it was ;) More right below.
> 
> > above that, since regvalue is supposed to only hold values from
> D6,D3,
> > so there is no need to &= 0x37 again.
> 
> For one thing, I didn't mean "&= 0x37 again" but "&= 0x37 *instead*".
> More precisely:
> 
> - gl518_write_value(client, GL518_REG_CONF, 0xb7 & regvalue);
> + gl518_write_value(client, GL518_REG_CONF, (regvalue &= 0x37));
> 
> Hope it's clearer now.
> 
> More generally, the way things are now, you are more or less silently
> forcing D0, D1 and D5 to 0. You can argue that it doesn't matter much
> because D5 is set back to 1 (and 0 again) later, and D0 and D1 are
> "reserved" so likely 0 anyway. Still this isn't how things should be
> done IMHO. The right (and safe) way of doing things is not to touch
> anything unless we have a reason and say we do.
> 
This just changes the original intention of regvalue.  It was only meant
to store the NoFan2 (D4) and Intclr flags (D2).  The other bits are to be 
changed within init.  As for reserved bits, it is usual to assume setting 
them to 0.  If their functions were changed, the it should be picked by
by the chip revision, and the driver should not work as it is now.

However, there are many ways to skin a cat.  Both methods work, and
I find that what I had initially is pretty clear, though regvalue could
be changed to D4D2value or something clearer, and that we are settings
the rest of the bits within the function.

I will pick up your reply tomorrow.

Cheers,
Hong-Gunn
