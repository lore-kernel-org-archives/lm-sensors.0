From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-Id: <20050426070003.GE5889@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504210207.02421.dtor_core@ameritech.net> <1114089504.29655.93.camel@uganda> <d120d50005042107314cbacdea@mail.gmail.com> <1114420131.8527.52.camel@uganda> <d120d50005042509326241a302@mail.gmail.com> <20050426001500.6a199399@zanzibar.2ka.mipt.ru> <d120d500050425132250916bcb@mail.gmail.com> <1114497816.8527.66.camel@uganda>
In-Reply-To: <1114497816.8527.66.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: dtor_core@ameritech.net, sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 26, 2005 at 10:43:36AM +0400, Evgeniy Polyakov wrote:
> On Mon, 2005-04-25 at 15:22 -0500, Dmitry Torokhov wrote:
> > On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > While thinking about locking schema
> > > with respect to sysfs files I recalled,
> > > why I implemented such a logic -
> > > now one can _always_ remove _any_ module
> > > [corresponding object is removed from accessible
> > > pathes and waits untill all exsting users are gone],
> > > which is very good - I really like it in networking model,
> > > while with whole device driver model
> > > if we will read device's file very quickly
> > > in several threads we may end up not unloading it at all.
> > 
> > I am sorrry, that is complete bull*. sysfs also allows removing
> > modules at an arbitrary time (and usually without annoying "waiting
> > for refcount" at that)... You just seem to not understand how driver
> > code works, thus the need of inventing your own schema.
> 
> Ok, let's try again - now with explanation, 
> since it looks like you did not even try to understand what I said.
> If you will remove objects from ->remove() callback
> you may end up with rmmod being stuck.

Yes, and that is acceptable.  networking implemented their own locking
method to allow unloading of their drivers in such a manner.  No other
subsystem is going to do that kind of implementation, so Dmitry is
correct here.

thanks,

greg k-h
