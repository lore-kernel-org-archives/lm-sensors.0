From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: I2C
Message-Id: <3D8D04A7.68D1664E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F184vhX4TFNZvqWslOL0000bbe9@hotmail.com>
In-Reply-To: <F184vhX4TFNZvqWslOL0000bbe9@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If anybody starts the ADM1032 driver we will note it on our new drivers
page
http://www2.lm-sensors.nu/~lm78/newdrivers.html
At the moment, none of the developers has a system on which to develop
this driver.
If you get started first, let us know.

On multimastering, do you mean two physical i2c bus masters?
If so, there is a proposal summarized in our i2c TODO list
http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/i2c/TODO
that may be helpful. Your comments are welcome.



Scott Tillman wrote:
> 
> I'm entering this discussion a little late, but I think I'm going to be
> heading the xbox-linux i2c work, so I thought I would introduce myself and
> add a few comments.
> 
> > > The ADM1032 is compatible with an existing driver we
> > > have, I believe.
> >
> >Don't think so.
> >As shown on our 'new drivers' page the ADM1032/LM90/MAX6657/8
> >are new chips we don't yet support. At first glance it
> >looks like we would need a new driver.
> >But the devices are fairly simple so we could whip up a
> >driver quickly if you wanted it. Since 3 companies
> >have come out with compatible chips I assume it will
> >be popular and we'll be developing a driver sooner or
> >later. If you're willing to test it, great.
> 
> We'd definitely be interested in testing the driver if you create it.
> Otherwise we will, in time, have to code it ourselves.  Either does work,
> but you could certainly do it faster than us.
> 
> > > > A different question: I haven't had a thorough
> > > > look into your code yet -
> > > > can drivers using i2c-amd756 register to receive
> > > > interrupts issued by the SMBus controller? The > > PIC includes some
> >watchdog functions (the box
> > > > gets reset/turned off when the eject or power
> > > > button gets pressed and the CPU does not respond
> > > > to the I2C message), and it would of course be
> > > > better to add interrupt handlers than do polling.
> > >
> > > Good question.  I'm not sure how best to address
> > > that, or which interrupt to use or who would listen
> > > to it.  Perhaps if a PIC monitoring daemon were
> > > written, and listened to that interrupt.  It could
> > > check that PIC status (either directly via > /dev/i2c-*, or by a chip
> >driver) when it received
> > > an interrupt.  I don't believe that the i2c-amd756
> > > lists to an interrupt... and I'm not sure what it
> > > would do if we configured it to... it would need to
> > > punt that to something else (probably a user-space
> > > app) to do something about it (like shutdown the
> > > system).
> >
> >Most of our drivers don't have interrupt support in
> >them.  If we add it we'll have to make sure we do it
> >in the "right" way, whatever that is :)
> 
> I have looked through the kernel i2c code (or at least I did about 6 months
> ago) and I didn't see any support for "multi-master" i2c buses.  As far as I
> can tell, these should be treated (from user space) as two separate devices.
>   The first is what you have, mastering of the i2c bus.  The second
> implements a blocking ioctl interface which unblocks when the client portion
> of the i2c device is addressed.
> 
> If I'm not completely off-base, I'd love to work on development of
> multimaster mode (possibly extending the bit algo to include multi-master
> support).  I'm not intimately familiar with the i2c core, but it didn't look
> overwhelmingly complex when last I looked.  If I *am* completely off-base,
> please let me know where my logic is flawed.
> 
> Let me know how I should procede in starting work on i2c multimastering.
> You can contact me directly or through the xbox-linux mailing list.
> 
> -SpeedBump
> 
> _________________________________________________________________
> Chat with friends online, try MSN Messenger: http://messenger.msn.com
