From: greg@kroah.com (Greg KH)
Date: Fri, 10 Feb 2006 23:17:22 +0000
Subject: [lm-sensors] A patch for w83791d for 2.6 kernel
Message-Id: <20060210231722.GA21468@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80602091334m2319cb42j5e2710bdc1d8f1ff@mail.gmail.com>
In-Reply-To: <5bfe43f80602091334m2319cb42j5e2710bdc1d8f1ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2006 at 02:23:00PM -0800, Charles Spirakis wrote:
> See below:
> 
> On 2/10/06, Greg KH <greg at kroah.com> wrote:
> > On Thu, Feb 09, 2006 at 01:34:42PM -0800, Charles Spirakis wrote:
> > > All --
> > >
> > > Below is a patch to add w83791d support into the 2.6 kernel. This
> > > patch was created off of the 2.6.15.3 base, but it should apply
> > > cleanly on many earlier kernels (been tried on 2.6.14.3 and 2.6.15.1).
> > >
> > > I've tried this on the system I have available here and it appears to work.
> > >
> > > Thanks!
> > >
> > > -- charles
> > >
> > >
> > > diff -urpN linux-2.6.15.3/Documentation/hwmon/w83791d
> > > linux-2.6.15.3-w83791d/Documentation/hwmon/w83791d
> > > --- linux-2.6.15.3/Documentation/hwmon/w83791d  1969-12-31
> > > 16:00:00.000000000 -0800
> >
> > It looks like your email client wrapped the lines of the patch, and ate
> > all of the tabs for breakfast and spit them back out as spaces :(
> >
> > Care to fix up your mailer problems and try again?
> >
> 
> Hmm... I'm not sure how to fix the mailer problem (just used gmail and
> cut/paste'd into the text box).

Oh that will never work :)

> If I sent the patch as an attachment instead, would the lm_sensor
> mailer handle it properly? Would it help to tar/compress it? Or would
> that make it worse?

No compression please, try attaching it as a plain text file.  The
SubmittingPatches document has some text on how to do this properly.

> >
> > > +}
> > > +
> > > +struct w83791d_data {
> > > +       struct i2c_client client;
> > > +       struct class_device *class_dev;
> > > +       struct semaphore lock;
> >
> > Perhaps a mutex instead?
> 
> In looking at the code, that particular lock isn't needed (the
> update_lock can be used for everything) so I'll remove it. However, as
> a general question, should the update_lock be changed? It is
> initialized via init_MUTEX() ~line 1280, but is there more that is
> needed? Is there a specific mutex type (struct mutex)? I don't
> remember seeing anything like that, but perhaps I missed it.

It's brand new, came after 2.6.15.

> Or should the name be more reflective of the fact there is only one
> owner of the lock allowed (aka update_mutex vs. update_lock)?

Should not matter.

thanks,

greg k-h

