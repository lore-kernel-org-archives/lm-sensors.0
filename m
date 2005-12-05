From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Mon, 05 Dec 2005 16:25:40 +0000
Subject: [lm-sensors] [patch] ds2482: i2c to 1-wire bridge
Message-Id: <20051205162540.GA14643@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512020734rb7d351bla98161d14c8cb70@mail.gmail.com>
In-Reply-To: <808c8e9d0512020734rb7d351bla98161d14c8cb70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 05, 2005 at 10:10:37AM -0600, Ben Gardner (gardner.ben at gmail.com) wrote:
> It seems that most w1 documentation refers to them as masters and
> slaves, so how about:
> drivers/w1/masters
> drivers/w1/slaves
> 
> I'll create three patch series:
>  - change 'unsigned long' to 'void *'
>  - move master and slave code into subfolders
>  - add ds2482
> 
> Does that sound OK?

Yes, it definitely does.
Thank you.

> Thanks,
> Ben
> 
> On 12/5/05, Evgeniy Polyakov <johnpol at 2ka.mipt.ru> wrote:
> > On Mon, Dec 05, 2005 at 09:40:20AM -0600, Ben Gardner (gardner.ben at gmail.com) wrote:
> > > If there aren't any objections, I'll follow the i2c layout and create
> > > a drivers/w1/busses folder and put the driver there.
> > > Should I also create a few patches to move the matrox_w1 and
> > > ds_w1_bridge stuff to that folder?
> > > Should I also create a drivers/w1/chips folder and move the family drivers?
> >
> > Hmm, any other names? There are no at least busses in the w1 world.
> > Maybe masters/bus_masters/controllers/something...?
> >
> > > > > +static u8 ds2482_w1_touch_bit(unsigned long data, u8 bit)
> > > > > +{
> > > > > +     struct ds2482_w1_chan *pchan = (struct ds2482_w1_chan *)data;
> > > >
> > > > That's an ugly cast. Can't it be avoided?
> > >
> > > Sure, if we change the w1 subsystem to use 'void *' as the user-data
> > > type instead of 'unsigned long'.
> > > Eugeniy - are you OK with that change?
> >
> > No problem, but make it in a separate patch.
> >
> > > Thanks,
> > > Ben
> >
> > --
> >         Evgeniy Polyakov
> >

-- 
	Evgeniy Polyakov

