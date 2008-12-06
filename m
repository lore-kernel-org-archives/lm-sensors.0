From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Dec 2008 08:48:32 +0000
Subject: Re: [lm-sensors] sensord exits on any error
Message-Id: <20081206094832.00738c42@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
In-Reply-To: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andy,

On Fri, 5 Dec 2008 18:34:37 -0600 (CST), Andy Poling wrote:
> On Fri, 5 Dec 2008, Jean Delvare wrote:
> > Multi-master bus?
> 
> We theorize that it may be the BIOS or ACPI periodically checking on CPU
> temperature or some similar activity.
>
> With older versions of the i2c-i801 driver, it would leave the SMBus wedged
> and it was game-over, but the most recent version (which we back-ported)
> finally seems to grapple effectively with SMBus collisions so that they're
> truly transient.

You should really figure out. If there is a second master on the bus
then that's OK, I2C/SMBus is designed for this. If OTOH either APCI or
the BIOS is using the Intel 82801 as well, then the risks of
misbehavior, data loss or corruption are high.

Which kernel are you running?

I wrote a patch years ago to detect concurrent accesses to the Intel
82801 SMBus, you might be interested in it.

> > Your changes to the w83793d drivers are IMHO not acceptable. It is up
> > to user-space to decide what to do when a sensor value can't be read.
> > Silently caching the values for an arbitrary period of 30 seconds isn't
> > nice. Returning errors immediately, OTOH would probably be better than
> > returning 0 as the driver does at the moment. Whether the error value
> > should be -EAGAIN or -EIO can be discussed. This is however a
> > non-trivial change due to the 2-second caching strategy that the driver
> > implements. But you probably already know that if you modified the
> > driver for your own use already. An easier approach would be to simply
> > retry on read failures, as I suspect the second read attempt would
> > almost always succeed.
> 
> Yep - agreed on the lengthy caching being problematic - we were looking to
> kill it dead on the first whack, and thus overshot the mark.
> 
> As you mentioned, the problem with the un-patched w83793 driver is that it
> returns bad data and no error on SMBus errors rather than returning an error.
> 
> If we want to be consistent with your paradigm of letting user-space decide
> how to deal with the problem, I think we should just return EAGAIN (or EIO) on
> a failure, and it would then be up to sensord to deal with it.  With our patch
> to sensord, it would naturally try again on the next read interval.
> 
> It wouldn't be at all difficult to remove the extended cache we added, leaving
> just the return of error on failure.
> 
> What do you think?

Yes, I would like to see your patch, and we'll apply it if it looks
correct.

> > Your fix to sensord is totally welcome. I could never find the time to
> > work on ticket #2330, so if you have a working patch I will be very
> > happy to review and apply it.
> 
> It looks like I can't add to the ticket.  What's the best way to submit a
> patch?  Just send it to this same list?  Is a patch against 2.10.7 OK?

Yes, a patch against 2.10.7 is OK. Please send it to the lm-sensors
mailing list, either inline or as an attachment. I'll take care of the
patch and the ticket. Alternatively, if you intend to contribute more
to the lm-sensors project in the future, I can create a wiki account
for you and you can attach your patch to the bug yourself. Tell me what
you prefer.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
