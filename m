From: Samuel Ortiz <sameo@linux.intel.com>
Date: Sun, 20 Sep 2009 23:48:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090920234836.GA32706@sortiz.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Sep 18, 2009 at 06:16:38PM +0200, Jean Delvare wrote:
> > > +static inline void superio_enter(struct w83627hf_sio_data *sio)
> > > +{
> > > +	mutex_lock(&sio->lock);
> > > +
> > > +	outb(0x87, sio->sioaddr);
> > > +	outb(0x87, sio->sioaddr);
> >
> > I'm not really happy with this one. The unbalanced locking here makes me feel
> > unconfortable.
> 
> Me, I don't have any objection. Callers will have to balance
> superio_enter and superio_exit anyway. So hiding the mutex in there
> seems reasonable.
Oh, hiding the mutex from the callers makes perfect sense to me. What I dont
really like is the fact that it's so easy to screw the locking (unbalance it,
unlock while not locking, unlock from a different process than the one that
locked, etc...) with this API. In fact, it doesnt bring much compared to
letting callers handling the locking by themselves.
Obviously, the only thing it brings is not having the callers know or care
about the MFD core locking. More comments below...

 
> > Something like that:
> > 
> > void superio_outb(struct w83627hf_sio_data *sio, int ld, int reg, int val)
> > {
> > 	mutex_lock(&sio->lock);
> > 
> > 	/* Enter */
> > 	outb(0x87, sio->sioaddr)
> > 	outb(0x87, sio->sioaddr)
> > 
> > 	/* Select module */
> > 	outb(0x07, sio->sioaddr);
> > 	outb(ld, sio->sioaddr + 1);
> > 
> > 	/* Write */
> > 	outb(reg, sio->sioaddr);
> > 	outb(val, sio->sioaddr + 1);
> > 
> > 	/* Exit */
> > 	outb(0xAA, sio->sioaddr);
> > 
> > 	mutex_unlock(&sio->lock);
> > }
> > 
> > would look saner to me. I know we're wasting many IO ops here, but it seems to
> > me that the subdevices get to call the superio API only at init time.
> > I think it's worth it as your subdevices wouldnt have to care about following
> > these error prone steps, and you wouldnt have any more unbalanced locking
> > risks.
> 
> The above has limitations. Think of the hwmon logical device enablement
> function which we discussed above. In this function we must read a
> register, and depending on the value, maybe write to it, but altering
> only one bit (so based on the original value.)
> 
> There is no way to achieve this in a race-free manner with your
> proposed superio_outb() function and the equivalent superio_inb()
> implementation. Even a superio_alterb() function wouldn't do, because
> we want to print a message.
I agree about that. But since this API is supposed to be used by subdevices, I
looked at what the only available one (w83627hf.c) would do with it. It seems
to me that this API would work well for w83627thf_read_gpio5() and
w83627thf_read_vid(). The more complex register manipulations found in
w83627hf_find() wouldnt have to use this API since it's an MFD core routine.
I definitely see the limitation of the above API, but it looks like it fills
the current need without introducing potential locking issues.
Now, you guys know way better the HW than me and can tell if this API will be
too limited for future subdevices. If that's the case, then let's go with
Rodolfo's proposal but I'd like to have an additional check for all the
superio_* routines (except superio_enter()), which would be a:
WARN_ON(!mutex_is_locked(&sio->lock));

That wont protect us from the "unlocking from a different process" bug, but it
would still be a progress.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
