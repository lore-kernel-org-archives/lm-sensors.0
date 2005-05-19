From: bkuschak@yahoo.com (Brian Kuschak)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: [PATCH] - i2c virtual adapter driver for multiplexed busses
Message-Id: <20031113180745.84587.qmail@web40909.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031111210329.77736.qmail@web40903.mail.yahoo.com>
In-Reply-To: <20031111210329.77736.qmail@web40903.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, 
See my comments below.
Regards, Brian

> 
> - I think i2c-virtual is really the algorithm driver
> (i2c-algo-virtual?).
>   It contains a common algorithm for virtual
> drivers.
> 
> - Therefore i2c-virtual_cb is the adapter driver,
> specific to the
>   PCA954x chips (ic2-pca954x?).
>   The algo/adapter boundary in the 405 driver you
> copied may be a little
> muddy.
>   See i2c-algo-bit and its many adapter drivers in
> sensors for examples.
> 

It's quite possible I muddied the boundaries here. 
The reason for keeping the main functionality out of
i2c-virtual_cb.c is that this file is where the
user-specific and platform-specific code resides.  The
makefiles in the patch don't actually use
i2c-virtual_cb.c - it was included more as an example
of usage.  In my case, at least, the callbacks are
where some of our proprietary code resides and I
wanted to keep that isolated.

> - I'd rather not add entries to struct
> i2c_algorithm, we just went
> through that
>   hell and are finishing a patch to go to Marcelo.
> Rather than
> xxx_exclusive,
>   we could use the (essentially unused)
> algo_control. i2c-core could
> recognize
>   that a driver is virtual by adding a functionality
> entry to identify
> that
>   it is virtual. If you really want it the way it is
> we need to put
> #ifdefs everywhere
>   so we can stay compatible, at least for now...
> 

Point well taken.  This sounds like a reasonable
change.

One comment is that the bus exclusivity and
multiplexing are two separate things.  Even a regular
non-multiplexed bus may require 'arbitration' with
other blades before being allowed to use it.  Likewise
some multiplexed busses may not require arbitration. 

> - If i2c-pca954x also registered as a chip driver
> (sensors-style)
>   (that is, be an i2c client as well) at addresses
> 0x70-77 then it will
>   get called whenever a device is found at that
> location, it can do
> detection
>   (if possible -doesn't look like it) and then
> register the new busses,
> and
>   everything gets bootstrapped. You'll get called
> anytime a bus
>   is registered. That's better than simply scanning
> the
>   adapters already present at module_init time.
> 

Yes, I originally thought about doing exactly that. 
In our application due to the variety of different HW
platforms it made more sense to register these busses
manually based on a priori knowledge of the HW.

I'll try to put together a little pcf954x client
driver to do the runtime registration of the virtual
busses, since that will likely be more useful for the
larger audience.

> - It's much easier for us if you give us a patch
> against CVS, or else
> patch
>   your kernel with our kernel patches first (see
> home page) and then
> give us a patch
>   against that kernel. At least for i2c-core.
> 

Understood.  Is your CVS based on 2.4 or 2.6?

> Brian Kuschak wrote:
> > 
> > Hi Greg, Mark,
> > 
> > As described in a previous email to this list,
> this is
> > a patch for simplified access to multiplexed i2c
> > busses.  A documentation file is included, as well
> as
> > an example (i2c-virtual_cb.c) of how to implement
> the
> > mux-control callbacks.
> > 
> > Tested on a heavily patched 2.4.19 kernel on
> embedded
> > PowerPC.  However, this patch is against a clean
> > kernel.org 2.4.19 tree.  I don't have the
> bandwidth to
> > port this to 2.6.0 right now, but I wanted to make
> it
> > available in case someone else finds it useful.
> > 
> > Comments/feedback welcome.
> > 
> > Thanks,
> > Brian Kuschak
> > 
> > __________________________________
> > Do you Yahoo!?
> > Protect your identity with Yahoo! Mail
> AddressGuard
> > http://antispam.yahoo.com/whatsnewfree
> > 
> > 
> >                                   Name:
> i2c_virtual.2_4_19.patch
> >    i2c_virtual.2_4_19.patch       Type: Plain Text
> (text/plain)
> >                            Description:
i2c_virtual.2_4_19.patch


__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
